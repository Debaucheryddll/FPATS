from __future__ import annotations

import argparse
import csv
import importlib.util
import sys
from dataclasses import dataclass
from pathlib import Path

import numpy as np
from scipy import signal


REPO_ROOT = Path(__file__).resolve().parents[1]
IIR_COEFFS_PATH = REPO_ROOT / "linien-server" / "linien_server" / "iir_coeffs.py"
IIR_COEFFS_SPEC = importlib.util.spec_from_file_location(
    "linien_server_iir_coeffs",
    IIR_COEFFS_PATH,
)
if IIR_COEFFS_SPEC is None or IIR_COEFFS_SPEC.loader is None:
    raise ImportError(f"Unable to load {IIR_COEFFS_PATH}")
IIR_COEFFS_MODULE = importlib.util.module_from_spec(IIR_COEFFS_SPEC)
IIR_COEFFS_SPEC.loader.exec_module(IIR_COEFFS_MODULE)

make_filter = IIR_COEFFS_MODULE.make_filter
quantize_filter = IIR_COEFFS_MODULE.quantize_filter


FAST_CHAIN_COEFF_WIDTH = 25
FAST_CHAIN_SHIFT = 23


@dataclass
class SimulationConfig:
    sample_rate_hz: float = 125e6
    duration_s: float = 1.2e-3
    modulation_frequency_hz: float = 50e3
    demod_multiplier: int = 1
    demod_phase_deg: float = 0.0
    signal_phase_deg: float = 35.0
    signal_amplitude: float = 0.65
    dc_offset: float = 0.05
    envelope_dc: float = 0.55
    envelope_ac: float = 0.35
    envelope_frequency_hz: float = 2.0e3
    spur_amplitude: float = 0.18
    spur_frequency_hz: float = 130e3
    noise_std: float = 0.03
    seed: int = 42
    output_plot: str = "data/demod_iir_chain.png"
    output_csv: str = "data/demod_iir_chain.csv"


def deg2rad(value_deg: float) -> float:
    return value_deg * np.pi / 180.0


def build_time_axis(cfg: SimulationConfig) -> np.ndarray:
    n_samples = int(round(cfg.duration_s * cfg.sample_rate_hz))
    if n_samples < 32:
        raise ValueError("Simulation duration is too short for the chosen sample rate.")
    return np.arange(n_samples, dtype=np.float64) / cfg.sample_rate_hz


def automatic_cutoff_hz(cfg: SimulationConfig) -> float:
    return min(cfg.modulation_frequency_hz / 2.0, 100e3)


def make_quantized_stage(
    filter_name: str,
    cutoff_hz: float,
    sample_rate_hz: float,
    order: int,
) -> tuple[np.ndarray, np.ndarray]:
    b_float, a_float = make_filter(filter_name, f=cutoff_hz / sample_rate_hz, k=1)
    b_quant, a_quant, shift = quantize_filter(
        b_float,
        a_float,
        shift=FAST_CHAIN_SHIFT,
        width=FAST_CHAIN_COEFF_WIDTH,
    )

    b_eff = np.array(b_quant, dtype=np.float64) / float(1 << shift)
    a_eff = np.array(a_quant, dtype=np.float64) / float(1 << shift)

    if len(b_eff) < order + 1:
        b_eff = np.pad(b_eff, (0, order + 1 - len(b_eff)))
    if len(a_eff) < order + 1:
        a_eff = np.pad(a_eff, (0, order + 1 - len(a_eff)))

    return b_eff, a_eff


def simulate_chain(cfg: SimulationConfig) -> dict[str, np.ndarray | float]:
    rng = np.random.default_rng(cfg.seed)
    t = build_time_axis(cfg)
    cutoff_hz = automatic_cutoff_hz(cfg)

    envelope = cfg.envelope_dc + cfg.envelope_ac * np.sin(
        2.0 * np.pi * cfg.envelope_frequency_hz * t
    )
    signal_phase = deg2rad(cfg.signal_phase_deg)
    ref_phase = deg2rad(cfg.demod_phase_deg)

    x_signal = (
        cfg.signal_amplitude
        * envelope
        * np.cos(
            2.0
            * np.pi
            * cfg.demod_multiplier
            * cfg.modulation_frequency_hz
            * t
            + signal_phase
        )
    )
    x_spur = cfg.spur_amplitude * np.cos(2.0 * np.pi * cfg.spur_frequency_hz * t + 0.4)
    x_noise = rng.normal(0.0, cfg.noise_std, size=t.shape)
    x = cfg.dc_offset + x_signal + x_spur + x_noise

    reference_phase = (
        2.0
        * np.pi
        * cfg.demod_multiplier
        * cfg.modulation_frequency_hz
        * t
        + ref_phase
    )
    lo_i = np.cos(reference_phase)
    lo_q = np.sin(reference_phase)

    i_raw = x * lo_i
    q_raw = x * lo_q

    b_c, a_c = make_quantized_stage("LP", cutoff_hz, cfg.sample_rate_hz, order=1)
    b_d, a_d = make_quantized_stage("LP", cutoff_hz, cfg.sample_rate_hz, order=2)

    i_c = signal.lfilter(b_c, a_c, i_raw)
    q_c = signal.lfilter(b_c, a_c, q_raw)
    i_d = signal.lfilter(b_d, a_d, i_c)
    q_d = signal.lfilter(b_d, a_d, q_c)

    return {
        "t": t,
        "x": x,
        "x_signal": x_signal,
        "envelope": envelope,
        "lo_i": lo_i,
        "lo_q": lo_q,
        "i_raw": i_raw,
        "q_raw": q_raw,
        "i_c": i_c,
        "q_c": q_c,
        "i_d": i_d,
        "q_d": q_d,
        "cutoff_hz": cutoff_hz,
        "b_c": b_c,
        "a_c": a_c,
        "b_d": b_d,
        "a_d": a_d,
    }


def db20(values: np.ndarray) -> np.ndarray:
    return 20.0 * np.log10(np.maximum(np.abs(values), 1e-14))


def save_csv(path: Path, result: dict[str, np.ndarray | float]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    t = np.asarray(result["t"])
    rows = zip(
        t,
        np.asarray(result["x"]),
        np.asarray(result["x_signal"]),
        np.asarray(result["envelope"]),
        np.asarray(result["i_raw"]),
        np.asarray(result["q_raw"]),
        np.asarray(result["i_c"]),
        np.asarray(result["q_c"]),
        np.asarray(result["i_d"]),
        np.asarray(result["q_d"]),
    )
    with path.open("w", newline="", encoding="utf-8") as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow(
            [
                "time_s",
                "adc_input",
                "useful_modulated_component",
                "slow_envelope",
                "i_raw",
                "q_raw",
                "i_after_iir_c",
                "q_after_iir_c",
                "i_after_iir_d",
                "q_after_iir_d",
            ]
        )
        writer.writerows(rows)


def save_plot(path: Path, result: dict[str, np.ndarray | float], cfg: SimulationConfig) -> None:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    t = np.asarray(result["t"])
    x = np.asarray(result["x"])
    i_raw = np.asarray(result["i_raw"])
    q_raw = np.asarray(result["q_raw"])
    i_c = np.asarray(result["i_c"])
    q_c = np.asarray(result["q_c"])
    i_d = np.asarray(result["i_d"])
    q_d = np.asarray(result["q_d"])
    envelope = np.asarray(result["envelope"])

    samples_per_period = max(8, int(round(cfg.sample_rate_hz / cfg.modulation_frequency_hz)))
    zoom_samples = min(len(t), 8 * samples_per_period)

    w_c, h_c = signal.freqz(np.asarray(result["b_c"]), np.asarray(result["a_c"]), worN=4096)
    w_d, h_d = signal.freqz(np.asarray(result["b_d"]), np.asarray(result["a_d"]), worN=4096)
    h_total = h_c * h_d
    f_hz = w_c * cfg.sample_rate_hz / (2.0 * np.pi)

    fig, axes = plt.subplots(3, 2, figsize=(14, 11))

    axes[0, 0].plot(t[:zoom_samples] * 1e6, x[:zoom_samples], label="ADC input")
    axes[0, 0].set_title("Input Waveform (Zoomed)")
    axes[0, 0].set_xlabel("Time (us)")
    axes[0, 0].set_ylabel("Amplitude")
    axes[0, 0].grid(True, alpha=0.3)
    axes[0, 0].legend(loc="best")

    axes[0, 1].plot(t * 1e3, envelope, label="Slow envelope")
    axes[0, 1].plot(t * 1e3, i_d, label="I after 2 IIRs", alpha=0.9)
    axes[0, 1].plot(t * 1e3, q_d, label="Q after 2 IIRs", alpha=0.9)
    axes[0, 1].set_title("Recovered Baseband Shape")
    axes[0, 1].set_xlabel("Time (ms)")
    axes[0, 1].set_ylabel("Amplitude")
    axes[0, 1].grid(True, alpha=0.3)
    axes[0, 1].legend(loc="best")

    axes[1, 0].plot(t[:zoom_samples] * 1e6, i_raw[:zoom_samples], label="I raw")
    axes[1, 0].plot(t[:zoom_samples] * 1e6, q_raw[:zoom_samples], label="Q raw")
    axes[1, 0].set_title("Raw Demodulated Signals")
    axes[1, 0].set_xlabel("Time (us)")
    axes[1, 0].set_ylabel("Amplitude")
    axes[1, 0].grid(True, alpha=0.3)
    axes[1, 0].legend(loc="best")

    axes[1, 1].plot(t * 1e3, i_c, label="I after iir_c")
    axes[1, 1].plot(t * 1e3, i_d, label="I after iir_d")
    axes[1, 1].plot(t * 1e3, q_c, label="Q after iir_c", alpha=0.8)
    axes[1, 1].plot(t * 1e3, q_d, label="Q after iir_d", alpha=0.8)
    axes[1, 1].set_title("IIR Filtering Along The Chain")
    axes[1, 1].set_xlabel("Time (ms)")
    axes[1, 1].set_ylabel("Amplitude")
    axes[1, 1].grid(True, alpha=0.3)
    axes[1, 1].legend(loc="best")

    axes[2, 0].semilogx(f_hz[1:], db20(h_c[1:]), label="Stage iir_c (1st order)")
    axes[2, 0].semilogx(f_hz[1:], db20(h_d[1:]), label="Stage iir_d (2nd order structure)")
    axes[2, 0].semilogx(f_hz[1:], db20(h_total[1:]), label="Cascade response", linewidth=2)
    axes[2, 0].axvline(float(result["cutoff_hz"]), color="tab:red", linestyle="--", label="auto cutoff")
    axes[2, 0].set_title("IIR Magnitude Response")
    axes[2, 0].set_xlabel("Frequency (Hz)")
    axes[2, 0].set_ylabel("Magnitude (dB)")
    axes[2, 0].grid(True, which="both", alpha=0.3)
    axes[2, 0].legend(loc="best")

    axes[2, 1].semilogx(f_hz[1:], np.unwrap(np.angle(h_c[1:])) * 180.0 / np.pi, label="Stage iir_c")
    axes[2, 1].semilogx(f_hz[1:], np.unwrap(np.angle(h_d[1:])) * 180.0 / np.pi, label="Stage iir_d")
    axes[2, 1].semilogx(f_hz[1:], np.unwrap(np.angle(h_total[1:])) * 180.0 / np.pi, label="Cascade response", linewidth=2)
    axes[2, 1].axvline(float(result["cutoff_hz"]), color="tab:red", linestyle="--", label="auto cutoff")
    axes[2, 1].set_title("IIR Phase Response")
    axes[2, 1].set_xlabel("Frequency (Hz)")
    axes[2, 1].set_ylabel("Phase (deg)")
    axes[2, 1].grid(True, which="both", alpha=0.3)
    axes[2, 1].legend(loc="best")

    fig.suptitle(
        "Demodulation + Cascaded IIR Simulation\n"
        f"f_mod={cfg.modulation_frequency_hz/1e3:.1f} kHz, multiplier={cfg.demod_multiplier}, "
        f"phase={cfg.demod_phase_deg:.1f} deg, auto cutoff={float(result['cutoff_hz'])/1e3:.1f} kHz"
    )
    fig.tight_layout()
    path.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(path, dpi=170)
    plt.close(fig)


def print_summary(result: dict[str, np.ndarray | float], cfg: SimulationConfig) -> None:
    i_d = np.asarray(result["i_d"])
    q_d = np.asarray(result["q_d"])
    envelope = np.asarray(result["envelope"])

    steady_slice = slice(len(i_d) // 5, None)
    corr_i = float(np.corrcoef(envelope[steady_slice], i_d[steady_slice])[0, 1])
    corr_q = float(np.corrcoef(envelope[steady_slice], q_d[steady_slice])[0, 1])

    print("=== Demod + IIR Simulation ===")
    print(f"sample_rate_hz: {cfg.sample_rate_hz:.3f}")
    print(f"duration_s: {cfg.duration_s:.6g}")
    print(f"modulation_frequency_hz: {cfg.modulation_frequency_hz:.3f}")
    print(f"demod_multiplier: {cfg.demod_multiplier}")
    print(f"demod_phase_deg: {cfg.demod_phase_deg:.3f}")
    print(f"automatic_cutoff_hz: {float(result['cutoff_hz']):.3f}")
    print()
    print("Stage iir_c coefficients:")
    print(f"  b = {np.array2string(np.asarray(result['b_c']), precision=8)}")
    print(f"  a = {np.array2string(np.asarray(result['a_c']), precision=8)}")
    print("Stage iir_d coefficients:")
    print(f"  b = {np.array2string(np.asarray(result['b_d']), precision=8)}")
    print(f"  a = {np.array2string(np.asarray(result['a_d']), precision=8)}")
    print()
    print("Recovered baseband correlation against slow envelope:")
    print(f"  corr(envelope, I_after_iir_d) = {corr_i:.6f}")
    print(f"  corr(envelope, Q_after_iir_d) = {corr_q:.6f}")


def parse_args() -> SimulationConfig:
    parser = argparse.ArgumentParser(
        description="Simulate the Linien demodulation + cascaded IIR chain and plot waveforms."
    )
    parser.add_argument("--sample-rate-hz", type=float, default=SimulationConfig.sample_rate_hz)
    parser.add_argument("--duration-s", type=float, default=SimulationConfig.duration_s)
    parser.add_argument("--modulation-frequency-hz", type=float, default=SimulationConfig.modulation_frequency_hz)
    parser.add_argument("--demod-multiplier", type=int, default=SimulationConfig.demod_multiplier)
    parser.add_argument("--demod-phase-deg", type=float, default=SimulationConfig.demod_phase_deg)
    parser.add_argument("--signal-phase-deg", type=float, default=SimulationConfig.signal_phase_deg)
    parser.add_argument("--signal-amplitude", type=float, default=SimulationConfig.signal_amplitude)
    parser.add_argument("--dc-offset", type=float, default=SimulationConfig.dc_offset)
    parser.add_argument("--envelope-dc", type=float, default=SimulationConfig.envelope_dc)
    parser.add_argument("--envelope-ac", type=float, default=SimulationConfig.envelope_ac)
    parser.add_argument("--envelope-frequency-hz", type=float, default=SimulationConfig.envelope_frequency_hz)
    parser.add_argument("--spur-amplitude", type=float, default=SimulationConfig.spur_amplitude)
    parser.add_argument("--spur-frequency-hz", type=float, default=SimulationConfig.spur_frequency_hz)
    parser.add_argument("--noise-std", type=float, default=SimulationConfig.noise_std)
    parser.add_argument("--seed", type=int, default=SimulationConfig.seed)
    parser.add_argument("--output-plot", default=SimulationConfig.output_plot)
    parser.add_argument("--output-csv", default=SimulationConfig.output_csv)
    args = parser.parse_args()
    return SimulationConfig(
        sample_rate_hz=args.sample_rate_hz,
        duration_s=args.duration_s,
        modulation_frequency_hz=args.modulation_frequency_hz,
        demod_multiplier=args.demod_multiplier,
        demod_phase_deg=args.demod_phase_deg,
        signal_phase_deg=args.signal_phase_deg,
        signal_amplitude=args.signal_amplitude,
        dc_offset=args.dc_offset,
        envelope_dc=args.envelope_dc,
        envelope_ac=args.envelope_ac,
        envelope_frequency_hz=args.envelope_frequency_hz,
        spur_amplitude=args.spur_amplitude,
        spur_frequency_hz=args.spur_frequency_hz,
        noise_std=args.noise_std,
        seed=args.seed,
        output_plot=args.output_plot,
        output_csv=args.output_csv,
    )


def main() -> None:
    cfg = parse_args()
    result = simulate_chain(cfg)
    save_csv(Path(cfg.output_csv), result)
    save_plot(Path(cfg.output_plot), result, cfg)
    print_summary(result, cfg)
    print(f"\nSaved plot: {Path(cfg.output_plot).resolve()}")
    print(f"Saved csv:  {Path(cfg.output_csv).resolve()}")


if __name__ == "__main__":
    main()
