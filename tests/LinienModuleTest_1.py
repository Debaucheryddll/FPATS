from migen import *
from migen.sim import run_simulation
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

        # 连接信号
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

# --- Testbench ---
def tb(dut):
    width = 14  # ADC 模拟输入位宽
    freq_mhz = 10.0
    fs_mhz = 125.0
    amp_a = 17542
    amp_b = 5413

    # 初始化调制模块（10 MHz）
    freq_reg = int(freq_mhz * (2 ** 32) / fs_mhz)
    yield dut.mod.freq.storage.eq(freq_reg)
    yield dut.mod.amp.storage.eq(16383)

    # 等待模块复位稳定
    for _ in range(100):
        yield dut.sim_adc_a.eq(0)
        yield dut.sim_adc_b.eq(0)
        yield

    # 注入 10 MHz 交流信号（持续若干周期）
    cycles = 256
    for _ in range(cycles):
        # 获取调制波形（通常是正弦波）
        cos_out = (yield dut.mod.y)
        ia = (cos_out * amp_a) >> 14
        ib = (cos_out * amp_b) >> 14

        yield dut.sim_adc_a.eq(int(ia))
        yield dut.sim_adc_b.eq(int(ib))
        yield

    # 等待除法器完成计算
    for _ in range(100):
        yield

    # 读取输出结果
    out_e_int = (yield dut.final_error_signal)
    out_e_f = out_e_int / float(2**20)

    ref = (amp_a - amp_b) / float(amp_a + amp_b)

    print("====== 10 MHz Test Result ======")
    print(f"amp_a = {amp_a}, amp_b = {amp_b}")
    print(f"ref   = {ref:+.6f}")
    print(f"out_e = {out_e_f:+.6f}")
    print("================================")
    # 可选：简单断言
    assert abs(out_e_f - ref) < 0.001, "Error too large!"

# --- 3. 运行测试 ---
def test_linien_error_simulation():
    dut = LinienErrorTest(width=14, signal_width=25, coeff_width=25)
    run_simulation(dut, tb(dut), vcd_name="linien_error_test.vcd")
