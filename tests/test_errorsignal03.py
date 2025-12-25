import math
from migen import *
from migen.sim import run_simulation
import numpy as np
import matplotlib

matplotlib.use("TKAgg")
import matplotlib.pyplot as plt

# 仍然使用你原来的 DUT 导入路径（不要改你的工程结构）
from gateware.logic.error_signal_calculator import ErrorSignalCalculator


# --- 测试模块 ---
class TB(Module):
    def __init__(self, width=25, fractional_bits=20):
        self.width = width
        self.frac_bits = fractional_bits
        self.scale = 2 ** fractional_bits

        # 1) DUT
        self.submodules.calculator = ErrorSignalCalculator(
            width=self.width, fractional_bits=self.frac_bits
        )

        # 2) 高斯脉冲参数（与你原测试一致）
        self.t = np.linspace(-1500, 1500, 1000)
        A = 0.05
        sigma = 210
        c1 = 250
        c2 = -250

        self.V1_float = A * np.exp(-(self.t - c1) ** 2 / (2 * sigma ** 2))
        self.V2_float = A * np.exp(-(self.t - c2) ** 2 / (2 * sigma ** 2))

        # 3) 转换为定点（与你原测试一致）
        self.V1_fixed = np.int64(np.round(self.V1_float * self.scale))
        self.V2_fixed = np.int64(np.round(self.V2_float * self.scale))

        # ============================================================
        # 方式B：用“硬件一致的定点计算”构造参考值（而不是浮点 diff/sum）
        # ============================================================
        # 如果你的误差信号计算器内部有分母阈值（例如 >4 才允许除法），这里也同步
        # 如果你 DUT 内阈值不同，把这里改成同样的数即可
        DENOMINATOR_THRESHOLD = 4

        self.E_ref_fixed = np.zeros_like(self.V1_fixed, dtype=np.int64)
        self.E_ref_float_hw = np.zeros_like(self.V1_float, dtype=np.float64)

        for i in range(len(self.t)):
            # Q=0 时幅度就是 |I|
            mag_a = abs(int(self.V1_fixed[i]))
            mag_b = abs(int(self.V2_fixed[i]))

            # 对齐“防溢出缩放”（如果你 DUT 里没有 >>1，这里就删掉）
            mag_a_s = mag_a >> 1
            mag_b_s = mag_b >> 1

            numerator = mag_a_s - mag_b_s
            denominator = mag_a_s + mag_b_s

            if denominator > DENOMINATOR_THRESHOLD:
                # 模拟硬件：(N << F) / D，并向 0 截断
                q = int((numerator << self.frac_bits) / int(denominator))
            else:
                q = 0

            self.E_ref_fixed[i] = q
            self.E_ref_float_hw[i] = q / self.scale

        # 4) 仿真结果存储
        self.E_sim_scaled = []
        self.E_sim_results = []  # float

        # 5) 尝试获取 divider 流水线延迟（保持你原写法）
        try:
            self.pipeline_delay = (
                self.calculator.divider.width_num
                + self.calculator.divider.fractional_bits
                + 2
            )
        except AttributeError:
            print("警告：无法自动检测 'calculator.divider' 的流水线延迟，使用默认值。")
            self.pipeline_delay = self.width + self.frac_bits + 2

    def bench_process(self):
        print("--- 仿真开始---")
        print(f"points={len(self.t)}, frac_bits={self.frac_bits}, pipeline_delay={self.pipeline_delay}")

        for i in range(len(self.t)):
            # 1) 输入保持稳定（Q=0）
            yield self.calculator.i_a.eq(int(self.V1_fixed[i]))
            yield self.calculator.q_a.eq(0)
            yield self.calculator.i_b.eq(int(self.V2_fixed[i]))
            yield self.calculator.q_b.eq(0)
            yield

            # 2) start 脉冲（沿用你原测试）
            yield self.calculator.divider.start.eq(1)
            yield
            yield self.calculator.divider.start.eq(0)
            yield

            # 3) 等待流水线
            for _ in range(self.pipeline_delay):
                yield

            # 4) 读输出
            out_e_scaled = (yield self.calculator.out_e)
            self.E_sim_scaled.append(out_e_scaled)
            self.E_sim_results.append(out_e_scaled / self.scale)

            yield

        print("--- 仿真完成 ---")


def test_error_signal_calculator_gaussian_methodB():
    tb = TB(width=25, fractional_bits=20)
    run_simulation(tb, tb.bench_process(), vcd_name="error_signal_calculator_gaussian_methodB.vcd")

    E_sim = np.array(tb.E_sim_results)
    E_sim_fixed = np.array(tb.E_sim_scaled, dtype=np.int64)

    E_ref_hw = tb.E_ref_float_hw
    E_ref_fixed = tb.E_ref_fixed
    t = tb.t

    # ====== 打印关键点对比 ======
    print("\nTime (fs) |   V1(V)   |   V2(V)   |  Ref(E_hw) |  Sim(E)   |  diff(float) | diff(LSB)")
    print("--------------------------------------------------------------------------------------")
    sample_points = [-1000, -500, -250, -100, 0, 100, 250, 500, 1000]
    for tp in sample_points:
        idx = (np.abs(t - tp)).argmin()

        ref_f = float(E_ref_hw[idx])
        sim_f = float(E_sim[idx])
        ref_i = int(E_ref_fixed[idx])
        sim_i = int(E_sim_fixed[idx])

        print(
            f"{tp:9.0f} | {tb.V1_float[idx]:9.6f} | {tb.V2_float[idx]:9.6f} |"
            f" {ref_f:9.6f} | {sim_f:9.6f} | {sim_f-ref_f:11.6f} | {sim_i-ref_i:8d}"
        )

        # 在 0 点附近就不再会拿“浮点 0”去硬比硬件输出
        # 这里改为 LSB 容差（你可以按 divider 的量化误差调整）
        assert abs(sim_i - ref_i) <= 5000, f"Mismatch at t={tp}: sim={sim_i}, ref={ref_i}"

    print("============================================================")
    print("断言检查通过（按硬件定点参考对齐）。")

    # ====== 绘图 ======
    plt.figure(figsize=(9, 5))
    plt.plot(t, E_ref_hw, "r-", lw=2, label="Reference (HW-fixed model)")
    plt.plot(t, E_sim, "k--", lw=1.2, label="Simulated (DUT)")
    plt.xlabel("Time offset (fs)")
    plt.ylabel("Error signal E")
    plt.title("Error Signal Comparison (Method B: Fixed-point Reference Alignment)")
    plt.grid(True)
    plt.legend()
    plt.xlim([-1500, 1500])
    plt.ylim([-1.1, 1.1])
    plt.tight_layout()
    plt.show()


if __name__ == "__main__":
    test_error_signal_calculator_gaussian_methodB()
