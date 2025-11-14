from migen import *
from migen.sim import run_simulation
import math

from gateware.logic.chains import FastChain
from gateware.logic.modulate import Modulate
from gateware.logic.error_signal_calculator import ErrorSignalCalculator


# --- 1. 创建测试模块，将 FastChain + ErrorSignalCalculator 集成 ---
class LinienErrorTest(Module):
    def __init__(self, width=14, signal_width=25, coeff_width=25):
        # 1.1 Modulate 信号源（参考时钟）
        self.submodules.mod = Modulate(width=width)

        # 1.2 Dummy offset signals
        dummy_offset_a = Signal((signal_width, True))
        dummy_offset_b = Signal((signal_width, True))
        self.comb += [
            dummy_offset_a.eq(0),
            dummy_offset_b.eq(0),
        ]

        # 1.3 FastChain 实例
        self.submodules.fast_a = FastChain(width, signal_width, coeff_width, self.mod, offset_signal=dummy_offset_a)
        self.submodules.fast_b = FastChain(width, signal_width, coeff_width, self.mod, offset_signal=dummy_offset_b)

        # 1.4 ErrorSignalCalculator 实例
        self.submodules.err_calc = ErrorSignalCalculator(width=signal_width)

        # 1.5 模拟 ADC 输入
        self.sim_adc_a = Signal((width, True))
        self.sim_adc_b = Signal((width, True))
        self.final_error_signal = Signal((signal_width, True))

        # 1.6 信号连线
        self.comb += [
            self.fast_a.adc.eq(self.sim_adc_a),
            self.fast_b.adc.eq(self.sim_adc_b),
            self.fast_a.demod.phase.eq(self.mod.phase),
            self.fast_b.demod.phase.eq(self.mod.phase),
            self.err_calc.i_a.eq(self.fast_a.out_i),
            self.err_calc.q_a.eq(self.fast_a.out_q),
            self.err_calc.i_b.eq(self.fast_b.out_i),
            self.err_calc.q_b.eq(self.fast_b.out_q),
            self.final_error_signal.eq(self.err_calc.out_e),
        ]


# --- 2. Testbench ---
def tb(dut):
    width = 14
    freq_mhz = 10.0
    fs_mhz = 125.0
    amp_a = 16000
    amp_b = 10000

    # 初始化 Modulate 模块
    freq_reg = int(freq_mhz * (2 ** 32) / fs_mhz)
    yield dut.mod.freq.storage.eq(freq_reg)
    yield dut.mod.amp.storage.eq(16383)

    # 等待稳定
    for _ in range(50):
        yield

    print("====== Simulating 10 MHz sinusoidal input ======")
    print("Cycle | ADC_A | ADC_B | I_a | Q_a | I_b | Q_b | |V1| |V2| | out_e")

    for n in range(50):  # 模拟 50 个采样点
        # 取当前调制输出
        cos_out = (yield dut.mod.y)
        ia_val = int((cos_out * amp_a) >> 14)
        ib_val = int((cos_out * amp_b) >> 14)
        yield dut.sim_adc_a.eq(ia_val)
        yield dut.sim_adc_b.eq(ib_val)
        yield

        # 读取 FastChain 输出
        i_a = (yield dut.fast_a.out_i)
        q_a = (yield dut.fast_a.out_q)
        i_b = (yield dut.fast_b.out_i)
        q_b = (yield dut.fast_b.out_q)
        out_e = (yield dut.final_error_signal)

        # 计算幅度（V1、V2）
        v1 = math.sqrt(i_a**2 + q_a**2) / (2 ** 20)
        v2 = math.sqrt(i_b**2 + q_b**2) / (2 ** 20)
        out_e_f = out_e / float(2 ** 20)

        print(f"{n:5d} | {ia_val:6d} | {ib_val:6d} | {i_a:6d} | {q_a:6d} | {i_b:6d} | {q_b:6d} | {v1:6.4f} | {v2:6.4f} | {out_e_f:+.6f}")

        yield

    # 打印理论参考
    ref = (amp_a - amp_b) / float(amp_a + amp_b)
    print("===============================================")
    print(f"Theoretical ref = {ref:+.6f}")


# --- 3. Run simulation ---
def test_linien_error_simulation():
    dut = LinienErrorTest(width=14, signal_width=25, coeff_width=25)
    run_simulation(dut, tb(dut), vcd_name="linien_error_test.vcd")
