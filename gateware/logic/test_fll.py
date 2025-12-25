import numpy as np
import pytest

migen = pytest.importorskip("migen")
from migen import Module, Signal, run_simulation

from gateware.logic.chains import FastChain
from gateware.logic.modulate import Modulate


@pytest.mark.slow
def test_demod_frequency_lock():
    width = 14
    freq_width = 32
    sample_rate = 1000.0

    start_freq = 20.0
    target_freq = 25.0
    transition_time = 2.0  # seconds used to ramp from start to target

    start_word = int((start_freq / sample_rate) * (2**freq_width))
    target_word = int((target_freq / sample_rate) * (2**freq_width))

    amplitude = (2 ** (width - 2)) - 1
    total_samples = int(sample_rate * 5)
    ramp_samples = int(sample_rate * transition_time)

    captured_words = []
    captured_freqs = []

    class Wrapper(Module):
        def __init__(self):
            self.submodules.mod = Modulate(width=width)
            offset_signal = Signal((25, True))
            self.submodules.chain = FastChain(
                width=width,
                signal_width=25,
                coeff_width=18,
                mod=self.mod,
                offset_signal=offset_signal,
            )

    def tb(dut):
        yield dut.mod.freq.storage.eq(start_word)
        yield dut.mod.amp.storage.eq(0)

        yield dut.chain.demod.freq_lock_en.storage.eq(1)
        yield dut.chain.demod.freq_smooth_shift.storage.eq(2)
        yield dut.chain.demod.phase_to_freq_shift.storage.eq(1)
        yield dut.chain.demod.freq_lock_gain.storage.eq(3)

        for idx in range(total_samples):
            current_freq = start_freq
            if idx < ramp_samples:
                current_freq += (target_freq - start_freq) * idx / float(ramp_samples)
            else:
                current_freq = target_freq

            phase = 2 * np.pi * current_freq * idx / sample_rate
            adc_value = int(np.sin(phase) * amplitude)
            yield dut.chain.adc.eq(adc_value)

            captured_words.append((yield dut.chain.demod.freq_word))
            captured_freqs.append(current_freq)

            # Print key datapoints every 200 samples to observe convergence behaviour
            if idx % 200 == 0:
                print(
                    f"idx={idx}, input_freq={current_freq:.3f} Hz, freq_word={(yield dut.chain.demod.freq_word)}"
                )

            yield

    dut = Wrapper()
    run_simulation(dut, tb(dut))

    final_section = captured_words[-int(sample_rate) :]
    locked_word = np.mean(final_section)

    print(f"start_word={start_word}, target_word={target_word}")
    print(f"locked_word_mean={locked_word:.2f}")

    # lock should converge near the target frequency word with a generous tolerance
    assert abs(locked_word - target_word) < target_word * 0.2