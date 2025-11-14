import pytest
import numpy as np
from migen import Module, Signal, run_simulation, Cat, If, Mux

# 导入所有需要的“器官”
# 1. 导入 FastChain，这是我们的“感官”（IQ解调器+滤波器）
from gateware.logic.chains import FastChain
# [cite_start]2. 导入我们为“飞秒系统” [cite: 2871-2888] 设计的“新心脏”
from gateware.logic.error_signal_calculator import ErrorSignalCalculator
# 3. 导入 FastChain 需要的“参考时钟”
from gateware.logic.modulate import Modulate


# --- 1. 创建“手术台”：一个模仿LinienModule新架构的测试模块 ---
# 位于 LinienModuleTest.py -> FpatDataPathTest
class FpatDataPathTest(Module):
    def __init__(self, width=14, signal_width=25, coeff_width=25):
        # 1.1 实例化“参考时钟” (Modulate)
        self.submodules.mod = Modulate(width=width)

        # +++ [ADDED] +++
        # 1.2 创建两个“假的”偏移信号
        # 我们在测试中不需要这个功能，所以我们只需要创建两个
        # 位宽正确、值为0的“占位”信号，来防止`None`错误的发生。
        dummy_offset_a = Signal((signal_width, True))
        dummy_offset_b = Signal((signal_width, True))
        self.comb += [
            dummy_offset_a.eq(0),
            dummy_offset_b.eq(0),
        ]
        # +++ [END ADDED] +++

        # 1.3 实例化两个“感官” (FastChain)
        # 【关键修改】现在我们将“假的”偏移信号作为第5个参数传递进去
        self.submodules.fast_a = FastChain(
            width,
            signal_width,
            coeff_width,
            self.mod,  # <-- 'mod' 应该是 self.mod
            offset_signal=dummy_offset_a,  # <-- 传入有效的信号
        )
        self.submodules.fast_b = FastChain(
            width,
            signal_width,
            coeff_width,
            self.mod,  # <-- 'mod' 应该是 self.mod
            offset_signal=dummy_offset_b,  # <-- 传入有效的信号
        )

        # 1.4 实例化“新心脏” (ErrorSignalCalculator)
        self.submodules.err_calc = ErrorSignalCalculator(width=signal_width)

        # --- 准备“体外循环”的输入输出 ---
        self.sim_adc_a = Signal((width, True))
        self.sim_adc_b = Signal((width, True))
        self.final_error_signal = Signal((signal_width, True))

        # --- 2. 核心连接 ---
        self.comb += [
            self.fast_a.adc.eq(self.sim_adc_a),
            self.fast_b.adc.eq(self.sim_adc_b),
        ]
        self.comb += [
            self.fast_a.demod.phase.eq(self.mod.phase),
            self.fast_b.demod.phase.eq(self.mod.phase),
        ]
        self.comb += [
            self.err_calc.i_a.eq(self.fast_a.out_i),
            self.err_calc.q_a.eq(self.fast_a.out_q),
            self.err_calc.i_b.eq(self.fast_b.out_i),
            self.err_calc.q_b.eq(self.fast_b.out_q),
        ]
        self.comb += [
            self.final_error_signal.eq(self.err_calc.out_e),
        ]


# --- 2. 创建“测试员”：Migen仿真测试平台 (Testbench) ---
# 【【【 这是修正后的、正确的 tb 函数 】】】

def tb(dut):
    """
    这个'tb' (testbench) 函数是“测试员”。
    'dut' (Device Under Test) 就是我们正在测试的 FpatDataPathTest 模块
    """

    # --- 仿真设置 ---
    # 宽度转换 (与你的FpatDataPathTest的__init__保持一致)
    width = 14
    signal_width = 25
    s = signal_width - width  # s = 11

    # 我们需要模拟一个 10MHz 的信号
    # 1. 计算10MHz在125MHz系统时钟下对应的频率寄存器值
    #    (这个公式来自 modulate.py 的 freq_width)
    freq_width = 32
    mod_freq_mhz = 10
    mod_freq_reg = int(mod_freq_mhz * (2 ** freq_width) / 125.0)

    # --- 仿真开始 ---
    print("【测试开始】正在初始化IIR滤波器和CORDIC... [cite: 1-404]")

    # 1. 设置Modulate模块(必须！)
    # 【修正】: Modulate模块在dut的顶层，所以我们访问 dut.mod
    yield dut.mod.freq.storage.eq(mod_freq_reg)
    yield dut.mod.amp.storage.eq(16383)  # 满幅度

    # [cite_start]2. 等待100个周期，让IIR滤波器和CORDIC [cite: 1-404] 稳定下来
    yield dut.sim_adc_a.eq(0)
    yield dut.sim_adc_b.eq(0)
    for _ in range(100):
        yield

    # --- 场景 1: |V1| > |V2| ---
    # 我们模拟一个真正的10MHz AC信号作为输入
    # 【最巧妙的技巧】:
    # [cite_start]`dut.mod` (Modulate模块) 内部的CORDIC [cite: 1-404] 已经为我们生成了
    # 完美的cos(wt)信号 (dut.mod.y)！

    v1_in_amp = 100
    v2_in_amp = 50

    print(f"【场景1】注入AC信号: A={v1_in_amp}*cos(wt), B={v2_in_amp}*cos(wt)。预期输出 > 0。")

    # 1. 注入信号 (动态生成)
    for i in range(200):  # 运行200个周期，让IIR滤波器稳定
        # 实时获取Modulate模块的cos输出 ([-16383, 16383])
        cos_out = (yield dut.mod.y)

        # 按比例缩放来模拟我们的输入信号
        yield dut.sim_adc_a.eq((cos_out * v1_in_amp) >> 14)
        yield dut.sim_adc_b.eq((cos_out * v2_in_amp) >> 14)

        yield

    # 2. 读取最终输出
    final_output = (yield dut.final_error_signal)

    # 读取内部信号，用于调试
    fa_out_i = (yield dut.fast_a.out_i)
    fb_out_i = (yield dut.fast_b.out_i)
    v1_out = (yield dut.err_calc.cordic_a.xo)
    v2_out = (yield dut.err_calc.cordic_b.xo)

    print(f"  FastChain A out (I_a) = {fa_out_i}")
    print(f"  FastChain B out (I_b) = {fb_out_i}")
    print(f"  内部 CORDIC |V1| = {v1_out}")  # 现在应该是合理的【正数】
    print(f"  内部 CORDIC |V2| = {v2_out}")  # 现在应该是合理的【正数】
    print(f"  【最终Error Signal E】 = {final_output}")

    # 3. 【断言】检查结果
    assert v1_out > v2_out, "CORDIC A的幅度应该大于CORDIC B"
    assert final_output > 0, "|V1| > |V2| 时，最终输出E应该为正！"

    # --- 场景 2：|V1| < |V2| ---
    v1_in_amp = 50
    v2_in_amp = 100

    print(f"【场景2】注入AC信号: A={v1_in_amp}*cos(wt), B={v2_in_amp}*cos(wt)。预期输出 < 0。")

    for i in range(200):  # 再运行200个周期
        cos_out = (yield dut.mod.y)
        yield dut.sim_adc_a.eq((cos_out * v1_in_amp) >> 14)
        yield dut.sim_adc_b.eq((cos_out * v2_in_amp) >> 14)
        yield

    final_output = (yield dut.final_error_signal)
    v1_out = (yield dut.err_calc.cordic_a.xo)
    v2_out = (yield dut.err_calc.cordic_b.xo)

    print(f"  内部 CORDIC |V1| = {v1_out}")
    print(f"  内部 CORDIC |V2| = {v2_out}")
    print(f"  【最终Error Signal E】 = {final_output}")
    assert v1_out < v2_out, "CORDIC A的幅度应该小于CORDIC B"
    assert final_output < 0, "|V1| < |V2| 时，最终输出E应该为负！"

    print("【测试成功】新的数据链路已成功跑通！")

# --- 3. 启动测试 ---
def test_fpat_data_path(plt):  # plt fixture 仍然保留

    # 1. 创建我们的“手术台”实例
    dut = FpatDataPathTest(
        width=14,
        signal_width=25,
        coeff_width=25  # 使用您在LinienModule中定义的实际位宽
    )

    # 2. 运行仿真！
    #    生成 vcd 波形文件，以便在 GTKWave 等工具中进行可视化调试
    run_simulation(dut, tb(dut), vcd_name="fpat_data_path_test.vcd")