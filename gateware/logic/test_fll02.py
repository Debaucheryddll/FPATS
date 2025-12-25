import numpy as np
import pytest
import matplotlib.pyplot as plt

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
    transition_time = 1.8  # seconds used to ramp from start to target

    start_word = int((start_freq / sample_rate) * (2**freq_width))
    target_word = int((target_freq / sample_rate) * (2**freq_width))

    amplitude = (2 ** (width - 2)) - 1
    ramp_samples = int(sample_rate * transition_time)
    settle_time = 2.0
    total_samples = int(sample_rate * (transition_time + settle_time))
    x = np.arange(total_samples)

    captured_words = []
    captured_freqs = []
    locked_means = []    # ★ 存储 locked_word_mean 的时间序列

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

        # FLL parameters
        yield dut.chain.demod.freq_lock_en.storage.eq(1)
        yield dut.chain.demod.freq_smooth_shift.storage.eq(5)
        yield dut.chain.demod.phase_to_freq_shift.storage.eq(1)
        yield dut.chain.demod.freq_lock_gain.storage.eq(4)

        for idx in range(total_samples):

            # Generate input signal
            if idx < ramp_samples:
                current_freq = start_freq + (target_freq - start_freq) * idx / float(ramp_samples)
            else:
                current_freq = target_freq

            phase = 2 * np.pi * current_freq * idx / sample_rate
            adc_value = int(np.sin(phase) * amplitude)
            yield dut.chain.adc.eq(adc_value)

            fw = (yield dut.chain.demod.freq_word)
            captured_words.append(fw)
            captured_freqs.append(current_freq)

            # 记录 locked_word_mean 的变化
            if idx >= sample_rate:
                last_sec = captured_words[-int(sample_rate):]
                locked_mean = np.mean(last_sec)
                locked_means.append(locked_mean)
            else:
                locked_means.append(np.nan)  # 前 1 秒没有平均值

            yield

    dut = Wrapper()
    run_simulation(dut, tb(dut))

    # Convert freq_word → Hz
    freq_word_hz = np.array(captured_words) * sample_rate / (2**freq_width)
    input_freq_hz = np.array(captured_freqs)

    # =====================================================
    # ★ 绘制 locked_word_mean 的变化曲线
    # =====================================================
    plt.figure(figsize=(10,5))
    # 画图时明确传 x
    plt.plot(x, freq_word_hz, label="FLL Output Frequency (Hz)", alpha=0.4)
    plt.plot(x, input_freq_hz, label="Input Frequency (Hz)", linewidth=2)
    plt.plot(x, np.array(locked_means) * sample_rate / (2 ** freq_width),
             label="locked_word_mean (Hz)", linewidth=3)
    plt.xlabel("Sample index")
    plt.ylabel("Frequency (Hz)")
    plt.title("FLL Locking Process (Includes locked_word_mean Evolution)")
    plt.grid(True)
    plt.legend()
    plt.tight_layout()
    plt.show()

    # Final section
    final_section = np.array(captured_words[-int(sample_rate):])
    locked_word = np.mean(final_section)

    print(f"start_word={start_word}, target_word={target_word}")
    print(f"final locked_word_mean={locked_word:.2f}")

    assert abs(locked_word - target_word) < target_word * 0.2