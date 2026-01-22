#
# 误差信号计算器模块
#可以计算浮点数的误差信号计算器
from migen import Module, Signal, Cat, If, Mux
from misoc.interconnect.csr import AutoCSR, CSRStatus

# --- [导入依赖] ---
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
        self.power_signal_out = Signal(width, name="power_signal_out")

        self.signal_in = []
        self.signal_out = [self.out_e, self.power_signal_out]
        self.state_in = []
        self.state_out = []

        # --- 为 PS 创建两个只读寄存器 ---
        # 寄存器 1: 误差信号 E
        self.csr_out_e = CSRStatus(width, name="out_e")
        # 寄存器 2: 功率信号 P (我们使用 'denominator' 作为代理)
        self.csr_power_signal_out = CSRStatus(width, name="power_signal_out")
        # --- 2. 内部信号 ---
        mag_a = Signal(width)
        mag_b = Signal(width)
        mag_a_scaled = Signal(width)  # 缩放后的幅度
        mag_b_scaled = Signal(width)  # 缩放后的幅度

        # --- 3. 幅度计算（方案A：功率/幅度平方，只保留高 width 位） ---
        # P = I^2 + Q^2（不做开方）
        # I/Q 为 width 位 => 平方是 2*width 位；两路相加得到 (2*width+1) 位。
        # 只保留 pa_wide/pb_wide 的最高 width 位直接作为 mag_a/mag_b。

        ia_sq = Signal((2 * width, True))
        qa_sq = Signal((2 * width, True))
        ib_sq = Signal((2 * width, True))
        qb_sq = Signal((2 * width, True))

        pa_wide = Signal((2 * width + 1, True))
        pb_wide = Signal((2 * width + 1, True))

        self.comb += [
            ia_sq.eq(self.i_a * self.i_a),
            qa_sq.eq(self.q_a * self.q_a),
            ib_sq.eq(self.i_b * self.i_b),
            qb_sq.eq(self.q_b * self.q_b),

            pa_wide.eq(ia_sq + qa_sq),
            pb_wide.eq(ib_sq + qb_sq),

            # 只取“高 width 位”
            # 对 width=25：pa_wide/pb_wide 是 51 位，取 [26:51]（最高 25 位）
            mag_a.eq(pa_wide[(2 * width + 1) - width: (2 * width + 1)]),
            mag_b.eq(pb_wide[(2 * width + 1) - width: (2 * width + 1)]),

            # 仍保留你原来的 /2 缩放，保证后面 denominator 加法更安全
            mag_a_scaled.eq(mag_a >> 1),
            mag_b_scaled.eq(mag_b >> 1),
        ]

        # --- 5. 计算分子和分母 ---
        numerator = Signal((width, True))
        denominator = Signal(width)
        denominator_wide = Signal(width + 1)
        mag_a_signed = Signal((width, True))
        mag_b_signed = Signal((width, True))

        DENOMINATOR_THRESHOLD = 4
        NOISE_FLOOR_THRESHOLD = 32
        safe_to_divide = Signal()
        error_limit = Signal((width, True))


        self.comb += [
            mag_a_signed.eq(mag_a_scaled),
            mag_b_signed.eq(mag_b_scaled),
            error_limit.eq(1 << fractional_bits),
            # 使用缩放后的值进行计算
            numerator.eq(mag_a_signed - mag_b_signed),  # <-- 现在这个加法是安全的！
            denominator_wide.eq(mag_a_scaled + mag_b_scaled),
            # 只有当分母足够大时，才允许除法
            safe_to_divide.eq(denominator > DENOMINATOR_THRESHOLD)
        ]
        self.comb += [
            If(
                denominator_wide[width],
                denominator.eq((1 << width) - 1),
            ).Else(
                denominator.eq(denominator_wide[:width]),
            )
        ]

        # --- 6. 实例化“定点数除法器” ---
        self.submodules.divider = PipelinedFloatDivider(
            width_num=width,
            width_den=width,
            fractional_bits=fractional_bits
        )

        # --- 7. 连接除法器 ---
        # 让除法器在 “分母足够大” 时持续工作（每拍都可以发起一次，流水线会连续出结果）
        start_en = Signal()
        self.comb += start_en.eq(safe_to_divide)

        self.comb += [
            self.divider.start.eq(start_en),
            self.divider.num.eq(numerator),
            self.divider.den.eq(denominator),
        ]

        # --- 8. 获取最终输出 ---
        # done 是单周期脉冲：有新结果就更新 out_e
        # 当分母太小且流水线空闲时，把 out_e 清零（可选逻辑，保持你原有行为）
        limited_quotient = Signal((width, True))
        self.comb += [
            If(
                self.divider.quotient > error_limit,
                limited_quotient.eq(error_limit),
            ).Elif(
                self.divider.quotient < -error_limit,
                limited_quotient.eq(-error_limit),
            ).Else(
                limited_quotient.eq(self.divider.quotient),
            )
        ]
        self.sync += [
            If(
                self.divider.done,
                If(
                    denominator > NOISE_FLOOR_THRESHOLD,
                    self.out_e.eq(limited_quotient),
                ).Else(
                    self.out_e.eq(0),
                ),
            ).Elif(~safe_to_divide & ~self.divider.busy, self.out_e.eq(0))
        ]

        denominator_reg = Signal(width)
        self.sync += denominator_reg.eq(denominator)
        self.comb += [
            # 将最终的 E 连接到 PS
            self.csr_out_e.status.eq(self.out_e),
            # 将 P (即 'denominator') 连接到 PS
            self.csr_power_signal_out.status.eq(denominator_reg),
            self.power_signal_out.eq(denominator_reg),
        ]
