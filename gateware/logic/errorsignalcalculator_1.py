#
# 误差信号计算器模块
#
from migen import Module, Signal, Cat, If
from misoc.interconnect.csr import AutoCSR, CSRStatus

# --- [导入依赖] ---
from gateware.logic.cordic import Cordic
from gateware.logic.divider_1 import PipelinedFloatDivider


class ErrorSignalCalculator(Module, AutoCSR):
    """
    计算 E = (|V1| - |V2|) / (|V1| + |V2|) [cite: 1-7, 1657]
    """

    def __init__(self, width=25, fractional_bits=10):
        # --- 1. 定义输入/输出 ---
        self.i_a = Signal((width, True))
        self.q_a = Signal((width, True))
        self.i_b = Signal((width, True))
        self.q_b = Signal((width, True))
        self.out_e = Signal((width, True))  # 最终的误差信号 E

        # --- 为 PS 创建两个只读寄存器 ---
        # 寄存器 1: 误差信号 E
        self.csr_error_signal = CSRStatus(width, name="error_signal")
        # 寄存器 2: 功率信号 P (我们使用 'denominator' 作为代理)
        self.csr_power_signal = CSRStatus(width, name="power_signal")
        # --- 2. 内部信号 ---
        mag_a = Signal((width, True))
        mag_b = Signal((width, True))
        mag_a_scaled = Signal((width, True))  # 缩放后的幅度
        mag_b_scaled = Signal((width, True))  # 缩放后的幅度

        # --- 3. CORDIC 模块 (计算幅度) ---
        cordic_eval_mode = "combinatorial"

        self.submodules.cordic_a = Cordic(
            width=width, cordic_mode="vector", func_mode="circular",
            eval_mode=cordic_eval_mode
        )
        self.submodules.cordic_b = Cordic(
            width=width, cordic_mode="vector", func_mode="circular",
            eval_mode=cordic_eval_mode
        )

        # --- 4. 连接 CORDIC 并进行【溢出修复】 ---
        self.comb += [
            self.cordic_a.xi.eq(self.i_a),
            self.cordic_a.yi.eq(self.q_a),
            mag_a.eq(self.cordic_a.xo),

            self.cordic_b.xi.eq(self.i_b),
            self.cordic_b.yi.eq(self.q_b),
            mag_b.eq(self.cordic_b.xo),

            # 在这里进行右移位缩放 (除以2)，防止后续加法溢出
            mag_a_scaled.eq(mag_a >> 1),
            mag_b_scaled.eq(mag_b >> 1),
        ]

        # --- 5. 计算分子和分母 ---
        numerator = Signal.like(mag_a)
        denominator = Signal.like(mag_a)

        DENOMINATOR_THRESHOLD = 4
        safe_to_divide = Signal()

        self.comb += [
            # 使用缩放后的值进行计算
            numerator.eq(mag_a_scaled - mag_b_scaled),
            denominator.eq(mag_a_scaled + mag_b_scaled),  # <-- 现在这个加法是安全的！
            # 只有当分母足够大时，才允许除法
            safe_to_divide.eq(denominator > DENOMINATOR_THRESHOLD)
        ]

        # --- 6. 实例化“定点数除法器” ---
        self.submodules.divider = PipelinedFloatDivider(
            width_num=width,
            width_den=width,
            fractional_bits=fractional_bits
        )

        # --- 7. 连接除法器 ---
        # 这是一个正确的“单周期脉冲”生成器 (边沿检测)
        start_pulse = Signal()
        safe_to_divide_reg = Signal()
        self.sync += safe_to_divide_reg.eq(safe_to_divide)
        self.comb += start_pulse.eq(safe_to_divide & ~safe_to_divide_reg)

        # 【注意】: 我们在 self.comb 中连接除法器的输入
        # PipelinedFloatDivider [cite: 1-404] 内部的 start 逻辑会锁存它们
        self.comb += [
            self.divider.start.eq(start_pulse),  # 只在安全信号的上升沿启动
            self.divider.num.eq(numerator),
            self.divider.den.eq(denominator),
        ]

        # --- 8. 获取最终输出 (带【组合循环修复】) ---

        self.sync += [
            If(self.divider.done,  # 当除法器报告计算完成时
               # 结果是 (N << F) / D，一个完美的定点数
               self.out_e.eq(self.divider.quotient)
               ).Elif(~self.divider.busy & ~start_pulse,
            # 如果除法器是空闲的 (比如因为分母太小而没启动)，则输出0
            self.out_e.eq(0)
        )
        ]
        denominator_reg = Signal.like(denominator)
        self.sync += denominator_reg.eq(denominator)
        self.comb += [
            # 将最终的 E 连接到 PS
            self.csr_error_signal.status.eq(self.out_e),
            # 将 P (即 'denominator') 连接到 PS
            self.csr_power_signal.status.eq(denominator_reg)
        ]