import argparse
import math
from pathlib import Path

import matplotlib
import numpy as np
from migen import Module, Signal
from migen.sim import run_simulation

from gateware.logic.chains import FastChain
from gateware.logic.errorsignalcalculator_1 import ErrorSignalCalculator

matplotlib.use("Agg")
import matplotlib.pyplot as plt

# NOTE:
# This simulation drives the FastChain/ErrCalc pipeline with a phase-coherent carrier
# and a much slower AM envelope. To keep runtime reasonable, `step_decimation` treats
# each simulation step as multiple 125 MHz ADC clock cycles. The carrier is generated
# from the same phase accumulator used by the demodulator, so the error signal remains
# representative of the AM envelope even when the effective sampling rate is coarse.


class PhaseProvider(Module):
    def __init__(self, width):
        self.phase = Signal(width)


class LinienErrorAMTest(Module):
    def __init__(self, width=14, signal_width=25, coeff_width=25, fractional_bits=20):
        self.submodules.phase_provider = PhaseProvider(width)

        dummy_offset_a = Signal((signal_width, True))
        dummy_offset_b = Signal((signal_width, True))
        self.comb += [
            dummy_offset_a.eq(0),
            dummy_offset_b.eq(0),
        ]

        self.submodules.fast_a = FastChain(
            width,
            signal_width,
            coeff_width,
            self.phase_provider,
            offset_signal=dummy_offset_a,
        )
        self.submodules.fast_b = FastChain(
            width,
            signal_width,
            coeff_width,
            self.phase_provider,
            offset_signal=dummy_offset_b,
        )

        self.submodules.err_calc = ErrorSignalCalculator(
            width=signal_width, fractional_bits=fractional_bits
        )

        self.sim_adc_a = Signal((width, True))
        self.sim_adc_b = Signal((width, True))
        self.final_error_signal = Signal((signal_width, True))

        self.comb += [
            self.fast_a.adc.eq(self.sim_adc_a),
            self.fast_b.adc.eq(self.sim_adc_b),
            self.err_calc.i_a.eq(self.fast_a.out_i),
            self.err_calc.q_a.eq(self.fast_a.out_q),
            self.err_calc.i_b.eq(self.fast_b.out_i),
            self.err_calc.q_b.eq(self.fast_b.out_q),
            self.final_error_signal.eq(self.err_calc.out_e),
        ]


class AMErrorSimBench(Module):
    def __init__(
        self,
        width=14,
        signal_width=25,
        coeff_width=25,
        fractional_bits=20,
        carrier_freq_hz=10e6,
        am_freq_hz=10.0,
        carrier_amp_v=0.5,
        am_amp_v=0.5,
        adc_full_scale_v=1.0,
        sample_rate_hz=125e6,
        step_decimation=1000,
        duration_s=0.2,
    ):
        self.width = width
        self.signal_width = signal_width
        self.fractional_bits = fractional_bits
        self.scale = 2**fractional_bits
        self.carrier_freq_hz = carrier_freq_hz
        self.am_freq_hz = am_freq_hz
        self.carrier_amp_v = carrier_amp_v
        self.am_amp_v = am_amp_v
        self.adc_full_scale_v = adc_full_scale_v
        self.sample_rate_hz = sample_rate_hz
        self.step_decimation = step_decimation
        self.duration_s = duration_s

        self.submodules.dut = LinienErrorAMTest(
            width=width,
            signal_width=signal_width,
            coeff_width=coeff_width,
            fractional_bits=fractional_bits,
        )

        self.samples = []
        self.time_s = []
        self.envelope_a = []
        self.envelope_b = []

    def bench_process(self):
        dt = self.step_decimation / self.sample_rate_hz
        total_steps = int(self.duration_s / dt)
        phase = 0.0

        max_adc = (2 ** (self.width - 1)) - 1
        adc_carrier_peak = int((self.carrier_amp_v / self.adc_full_scale_v) * max_adc)
        mod_index = self.am_amp_v / self.carrier_amp_v

        warmup_cycles = max(
            200,
            self.dut.err_calc.divider.width_num
            + self.dut.err_calc.divider.fractional_bits
            + 4,
        )

        for step in range(total_steps):
            t = step * dt
            phase = (phase + (2 * math.pi * self.carrier_freq_hz * dt)) % (
                2 * math.pi
            )
            phase_code = int((phase / (2 * math.pi)) * (1 << self.width)) & (
                (1 << self.width) - 1
            )

            envelope_a_v = self.carrier_amp_v
            envelope_b_v = self.carrier_amp_v * (
                1.0 + mod_index * math.sin(2 * math.pi * self.am_freq_hz * t)
            )

            carrier = math.sin(phase)
            adc_a = int((envelope_a_v / self.adc_full_scale_v) * max_adc * carrier)
            adc_b = int((envelope_b_v / self.adc_full_scale_v) * max_adc * carrier)

            yield self.dut.phase_provider.phase.eq(phase_code)
            yield self.dut.sim_adc_a.eq(adc_a)
            yield self.dut.sim_adc_b.eq(adc_b)
            yield

            if step >= warmup_cycles:
                out_e_scaled = (yield self.dut.final_error_signal)
                self.samples.append(out_e_scaled / self.scale)
                self.time_s.append(t)
                self.envelope_a.append(envelope_a_v)
                self.envelope_b.append(envelope_b_v)


def parse_args():
    parser = argparse.ArgumentParser(
        description="Linien module chain AM error signal simulation"
    )
    parser.add_argument("--carrier-freq", type=float, default=10e6)
    parser.add_argument("--am-freq", type=float, default=10.0)
    parser.add_argument("--carrier-amp", type=float, default=0.5)
    parser.add_argument("--am-amp", type=float, default=0.5)
    parser.add_argument("--adc-full-scale", type=float, default=1.0)
    parser.add_argument("--sample-rate", type=float, default=125e6)
    parser.add_argument("--step-decimation", type=int, default=1000)
    parser.add_argument("--duration", type=float, default=0.2)
    parser.add_argument(
        "--output-prefix",
        type=Path,
        default=Path("data/linienmodule_am_error"),
    )
    return parser.parse_args()


def main():
    args = parse_args()

    bench = AMErrorSimBench(
        carrier_freq_hz=args.carrier_freq,
        am_freq_hz=args.am_freq,
        carrier_amp_v=args.carrier_amp,
        am_amp_v=args.am_amp,
        adc_full_scale_v=args.adc_full_scale,
        sample_rate_hz=args.sample_rate,
        step_decimation=args.step_decimation,
        duration_s=args.duration,
    )

    run_simulation(bench, bench.bench_process())

    output_prefix = args.output_prefix
    output_prefix.parent.mkdir(parents=True, exist_ok=True)

    time_s = np.array(bench.time_s)
    error_signal = np.array(bench.samples)
    envelope_a = np.array(bench.envelope_a)
    envelope_b = np.array(bench.envelope_b)

    csv_path = output_prefix.with_suffix(".csv")
    np.savetxt(
        csv_path,
        np.column_stack((time_s, envelope_a, envelope_b, error_signal)),
        delimiter=",",
        header="time_s,envelope_a_v,envelope_b_v,error_signal",
        comments="",
    )

    plt.figure(figsize=(10, 6))
    plt.subplot(2, 1, 1)
    plt.plot(time_s, envelope_a, label="A envelope (0.5 V)")
    plt.plot(time_s, envelope_b, label="B envelope (AM 10 Hz, 0.5 V)")
    plt.ylabel("Envelope (V)")
    plt.legend()
    plt.grid(True)

    plt.subplot(2, 1, 2)
    plt.plot(time_s, error_signal, label="Error signal")
    plt.xlabel("Time (s)")
    plt.ylabel("Error signal (E)")
    plt.legend()
    plt.grid(True)

    plt.tight_layout()
    png_path = output_prefix.with_suffix(".png")
    plt.savefig(png_path, dpi=150)

    print(f"Saved CSV: {csv_path}")
    print(f"Saved plot: {png_path}")


if __name__ == "__main__":
    main()