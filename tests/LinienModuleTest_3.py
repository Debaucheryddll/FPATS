import math
from migen import *
from migen.sim import run_simulation
import numpy as np
import matplotlib

matplotlib.use('TKAgg')  # 使用 'TKAgg' 后端以确保绘图窗口弹出
import matplotlib.pyplot as plt

# --- 从你的“全链路测试”中导入所需模块 ---
# (请确保这些模块在你的 Python 路径中)
from gateware.logic.chains import FastChain
from gateware.logic.modulate import Modulate
from gateware.logic.error_signal_calculator import ErrorSignalCalculator


# --- 1. “全链路测试”的硬件定义 (来自你的第二个文件) ---
# (这部分无需修改)
class LinienErrorTest(Module):
    def __init__(self, width=14, signal_width=25, coeff_width=25, fractional_bits=20):
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
        self.submodules.err_calc = ErrorSignalCalculator(width=signal_width, fractional_bits=fractional_bits)

        # 1.5 模拟 ADC 输入
        self.sim_adc_a = Signal((width, True))
        self.sim_adc_b = Signal((width, True))
        self.final_error_signal = Signal((signal_width, True))

        # 1.6 信号连线
        self.comb += [
            self.fast_a.adc.eq(self.sim_adc_a),
            self.fast_b.adc.eq(self.sim_adc_b),
            self.err_calc.i_a.eq(self.fast_a.out_i),
            self.err_calc.q_a.eq(self.fast_a.out_q),
            self.err_calc.i_b.eq(self.fast_b.out_i),
            self.err_calc.q_b.eq(self.fast_b.out_q),
            self.final_error_signal.eq(self.err_calc.out_e),
        ]


# --- 2. 新的 Testbench 类 (修正后的核心) ---
class LinienChainTB(Module):
    def __init__(self, width=14, signal_width=25, coeff_width=25, fractional_bits=20):
        # 存储参数
        self.width = width
        self.signal_width = signal_width
        self.fractional_bits = fractional_bits
        self.scale = 2 ** fractional_bits

        # 1. 实例化 DUT (现在是 self.submodules 的一部分)
        self.submodules.dut = LinienErrorTest(
            width=width,
            signal_width=signal_width,
            coeff_width=coeff_width,
            fractional_bits=fractional_bits
        )

        # ====== A. 激励信号参数 (存储为实例属性) ======
        # 这也是为什么仿真很快 (64秒)
        self.t = np.linspace(-1500, 1500, 100)

        A_peak = 16000.0
        sigma = 210
        c1 = 250
        c2 = -250

        self.V1_float = A_peak * np.exp(-(self.t - c1) ** 2 / (2 * sigma ** 2))
        self.V2_float = A_peak * np.exp(-(self.t - c2) ** 2 / (2 * sigma ** 2))

        # 理论参考 (存储为实例属性)
        sum_val = np.abs(self.V1_float) + np.abs(self.V2_float)
        diff_val = np.abs(self.V1_float) - np.abs(self.V2_float)
        self.E_ref = np.divide(diff_val, sum_val, out=np.zeros_like(diff_val), where=sum_val != 0)

        # ====== B. 仿真结果存储 (存储为实例属性) ======
        self.E_sim_results = []  # 将由 bench_process 填充

        # ====== C. 流水线参数 ======
        try:
            self.pipeline_delay = self.dut.err_calc.divider.width_num + self.dut.err_calc.divider.fractional_bits + 2
        except AttributeError:
            print("警告：无法自动检测 'err_calc.divider' 的流水线延迟。")
            self.pipeline_delay = self.signal_width + self.fractional_bits + 2

    def bench_process(self):
        """
        Migen 仿真生成器 (Testbench 进程)
        """

        # ====== B. RF 载波参数 ======
        freq_mhz = 10.0
        fs_mhz = 125.0
        freq_reg = int(freq_mhz * (2 ** 32) / fs_mhz)
        yield self.dut.mod.freq.storage.eq(freq_reg)
        yield self.dut.mod.amp.storage.eq(16383)

        print(f"--- 仿真开始 (全链路高斯脉冲) ---")
        print(f"检测到 {len(self.t)} 个时间点。")
        print(f"使用的流水线延迟: {self.pipeline_delay} 个时钟周期。")

        # FastChain IIR 滤波器稳定
        for _ in range(50):
            yield

        # ====== D. 仿真循环 ======
        for i in range(len(self.t)):
            # 1. 获取载波
            cos_out = (yield self.dut.mod.y)

            # 2. 获取幅度 (从 self 读取)
            amp_a = self.V1_float[i]
            amp_b = self.V2_float[i]

            # 3. 幅度调制
            ia_val = int((cos_out * int(amp_a)) >> 14)
            ib_val = int((cos_out * int(amp_b)) >> 14)

            # 4. 设置 ADC 输入 (到 self.dut)
            yield self.dut.sim_adc_a.eq(ia_val)
            yield self.dut.sim_adc_b.eq(ib_val)

            # 5. 等待 FastChain 延迟
            fast_chain_latency = 5
            for _ in range(fast_chain_latency):
                yield

            # 6. 启动 ErrorSignalCalculator
            yield self.dut.err_calc.divider.start.eq(1)
            yield
            yield self.dut.err_calc.divider.start.eq(0)
            yield

            # 7. 等待 ErrorSignalCalculator 流水线
            for _ in range(self.pipeline_delay):
                yield

            # 8. 读取最终信号
            out_e_scaled = (yield self.dut.final_error_signal)
            out_e_float = out_e_scaled / self.scale

            # *** 关键修正 ***
            # 将结果存储回类的实例属性中
            self.E_sim_results.append(out_e_float)

            yield  # 结束当前点的处理

        print(f"--- 仿真完成 ---")
        # 此生成器不需要 'return'


# --- 3. Run simulation (分析逻辑现在是正确的) ---
def test_linien_error_gaussian_chain():
    width = 14
    signal_width = 25
    coeff_width = 25
    fractional_bits = 20

    # 1. 实例化我们的全链路 Testbench 类
    tb = LinienChainTB(
        width=width,
        signal_width=signal_width,
        coeff_width=coeff_width,
        fractional_bits=fractional_bits
    )

    # 2. 运行 Migen 仿真
    #    run_simulation 会在 tb 实例上运行 tb.bench_process()
    run_simulation(tb, tb.bench_process(), vcd_name="linien_error_chain_gaussian.vcd")

    # 3. 仿真后处理 (*** 关键修正 ***)
    #    现在我们从 tb 实例中安全地读回数据
    t = tb.t
    E_ref = tb.E_ref
    E_sim = np.array(tb.E_sim_results)  # 转换为 numpy 数组
    V1_float = tb.V1_float
    V2_float = tb.V2_float

    # ====== 4. 打印关键点对比表 ======
    # (这部分代码现在可以正常工作了)
    print("\nTime (fs) |  |V1_amp| |  |V2_amp| |    Ref E |    Sim E")
    print("------------------------------------------------------------")

    sample_points = [-1000, -500, -250, -100, 0, 100, 250, 500, 1000]
    for tp in sample_points:
        idx = (np.abs(t - tp)).argmin()

        if idx < len(E_sim):
            E_ref_val = E_ref[idx]
            E_sim_val = E_sim[idx]

            print(f"{tp:9.0f} | {V1_float[idx]:9.1f} | {V2_float[idx]:9.1f} | "
                  f"{E_ref_val:9.6f} | {E_sim_val:9.6f}")

            if tp == 0:
                assert abs(
                    E_sim_val - E_ref_val) < 0.2, f"out_e mismatch at t={tp}: Sim={E_sim_val} vs Ref={E_ref_val}"
        else:
            print(f"警告: 在 t={tp} 处缺少仿真数据。")

    print("============================================================\n")

    # ====== 5. 绘图 ======
    # (这部分代码现在也可以正常工作了)
    plt.figure(figsize=(10, 7))

    plt.subplot(2, 1, 1)
    plt.plot(t, V1_float, 'r-', label='V1 Amplitude Profile')
    plt.plot(t, V2_float, 'b-', label='V2 Amplitude Profile')
    plt.title('Gaussian Pulse Amplitudes (Modulation)')
    plt.xlabel('Time offset (fs)')
    plt.ylabel('Amplitude (ADC units)')
    plt.legend()
    plt.grid(True)

    plt.subplot(2, 1, 2)
    plt.plot(t, E_ref, 'r-', lw=2, label='Reference E_ref (Theory)')
    plt.plot(t, E_sim, 'k--', lw=1.2, label='Simulated E_sim (Full Chain)')
    plt.xlabel('Time offset (fs)')
    plt.ylabel('Error signal E')
    plt.title('Error Signal Comparison (Full Chain)')
    plt.legend()
    plt.grid(True)
    plt.xlim([-1500, 1500])
    plt.ylim([-1.1, 1.1])

    plt.tight_layout()
    plt.show()


if __name__ == "__main__":
    test_linien_error_gaussian_chain()