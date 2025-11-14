import math
from migen import *
from migen.sim import run_simulation
import numpy as np
import matplotlib

matplotlib.use('TKAgg')  # 使用 'TKAgg' 后端以确保绘图窗口弹出
import matplotlib.pyplot as plt

# 假设 ErrorSignalCalculator 在这个路径
from gateware.logic.error_signal_calculator import ErrorSignalCalculator


# --- 测试模块 ---
class TB(Module):
    def __init__(self, width=25, fractional_bits=10):
        self.width = width
        self.frac_bits = fractional_bits
        self.scale = 2 ** fractional_bits

        # 1. 实例化被测试的模块 (DUT)
        self.submodules.calculator = ErrorSignalCalculator(width=self.width, fractional_bits=self.frac_bits)

        # ====== 2. 高斯脉冲参数 (来自你的第一个文件) ======
        self.t = np.linspace(-1500, 1500, 1000)
        A = 0.05
        sigma = 210
        c1 = 250
        c2 = -250

        # 浮点数激励信号
        self.V1_float = A * np.exp(-(self.t - c1) ** 2 / (2 * sigma ** 2))
        self.V2_float = A * np.exp(-(self.t - c2) ** 2 / (2 * sigma ** 2))

        # 转换为定点整数格式
        self.V1_fixed = np.int32(self.V1_float * self.scale)
        self.V2_fixed = np.int32(self.V2_float * self.scale)

        # ====== 3. 理论误差信号 (来自你的第一个文件) ======
        # 注意：这里我们假设 Q=0，所以幅度 |V| 就是 |I|
        sum_val = np.abs(self.V1_float) + np.abs(self.V2_float)
        diff_val = np.abs(self.V1_float) - np.abs(self.V2_float)
        # 处理除零情况 (t=0 时 V1 和 V2 可能都非常接近 0)
        self.E_ref = np.divide(diff_val, sum_val, out=np.zeros_like(diff_val), where=sum_val != 0)

        # ====== 4. 仿真结果存储 ======
        self.E_sim_results = []  # 存储浮点结果
        self.E_sim_scaled = []  # 存储原始整数结果

        # 尝试获取流水线延迟
        try:
            # 这里的关键是访问 DUT 内部的流水线参数
            # 这与你第二个文件中的逻辑一致
            self.pipeline_delay = self.calculator.divider.width_num + self.calculator.divider.fractional_bits + 2
        except AttributeError:
            print("警告：无法自动检测 'calculator.divider' 的流水线延迟。")
            print("将使用一个默认值。这可能会导致仿真失败。")
            # 如果结构发生变化，提供一个备用值
            self.pipeline_delay = self.width + self.frac_bits + 2

    def bench_process(self):
        """
        Migen 仿真生成器
        """
        print(f"--- 仿真开始 ---")
        print(f"检测到 {len(self.t)} 个时间点。")
        print(f"使用的流水线延迟: {self.pipeline_delay} 个时钟周期。")

        # ====== 5. 逐点输入并读取输出 (协议来自你的第二个文件) ======
        for i in range(len(self.t)):
            # 1. 设置输入信号 (来自第一个文件)
            # 保持输入信号稳定
            yield self.calculator.i_a.eq(int(self.V1_fixed[i]))
            yield self.calculator.q_a.eq(0)  # 保持 Q=0
            yield self.calculator.i_b.eq(int(self.V2_fixed[i]))
            yield self.calculator.q_b.eq(0)  # 保持 Q=0
            yield  # 稳定输入

            # 2. 发送 'start' 脉冲 (来自第二个文件)
            yield self.calculator.divider.start.eq(1)
            yield
            yield self.calculator.divider.start.eq(0)
            yield  # 完成 'start' 脉冲

            # 3. 等待流水线完成 (来自第二个文件)
            # 在这段时间内，输入必须保持不变
            for _ in range(self.pipeline_delay):
                yield

            # 4. 读取输出
            out_e_scaled = (yield self.calculator.out_e)

            # 5. 存储结果
            self.E_sim_scaled.append(out_e_scaled)
            self.E_sim_results.append(out_e_scaled / self.scale)

            yield  # 结束当前点的处理

        print(f"--- 仿真完成 ---")


# --- 主函数入口 ---
def test_error_signal_calculator_gaussian():
    # 1. 实例化测试平台
    tb = TB(width=25, fractional_bits=20)

    # 2. 运行 Migen 仿真
    run_simulation(tb, tb.bench_process(), vcd_name="error_signal_calculator_gaussian.vcd")

    # 3. 仿真后处理 (来自你的第一个文件)
    E_sim = np.array(tb.E_sim_results)
    E_ref = tb.E_ref
    t = tb.t

    # ====== 4. 打印关键点对比表 ======
    print("\nTime (fs) |   |V1| (V) |   |V2| (V) |    Ref E |    Sim E")
    print("------------------------------------------------------------")

    sample_points = [-1000, -500, -250, -100, 0, 100, 250, 500, 1000]
    for tp in sample_points:
        idx = (np.abs(t - tp)).argmin()

        # 检查仿真数据是否足够（以防万一）
        if idx < len(E_sim):
            E_ref_val = E_ref[idx]
            E_sim_val = E_sim[idx]

            print(f"{tp:9.0f} | {tb.V1_float[idx]:10.6f} | {tb.V2_float[idx]:10.6f} | "
                  f"{E_ref_val:9.6f} | {E_sim_val:9.6f}")

            # 断言检查 (来自你的第二个文件)
            assert abs(E_sim_val - E_ref_val) < 0.01, f"out_e mismatch at t={tp}: Sim={E_sim_val} vs Ref={E_ref_val}"
        else:
            print(f"警告: 在 t={tp} 处缺少仿真数据。")

    print("============================================================\n")
    print("断言检查通过。")

    # ====== 5. 绘图 ======
    plt.figure(figsize=(8, 5))
    plt.plot(t, E_ref, 'r-', lw=2, label='Reference E_ref (Theory)')
    plt.plot(t, E_sim, 'k--', lw=1.2, label='Simulated E_sim (Hardware)')
    plt.xlabel('Time offset (fs)')
    plt.ylabel('Error signal E')
    plt.title('Error Signal Comparison (Gaussian Pulse) - White Box Test')
    plt.legend()
    plt.grid(True)
    plt.xlim([-1500, 1500])
    plt.ylim([-1.1, 1.1])
    plt.show()


if __name__ == "__main__":
    test_error_signal_calculator_gaussian()