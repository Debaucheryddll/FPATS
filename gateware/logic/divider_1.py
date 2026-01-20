from migen import Module, Signal, Cat, Mux, If
from functools import reduce
from operator import or_


class PipelinedFloatDivider(Module):
    """
    流水线【有符号】【伪浮点】除法器

    计算: Q = (num << fractional_bits) / den
    输出为定点表示，低 fractional_bits 位为小数

    参数:
        width_num (int)         : 分子宽度（输出宽度也为 width_num）
        width_den (int)         : 分母宽度
        fractional_bits (int)   : 小数位数，可由使用者指定
    """

    def __init__(self, width_num=25, width_den=25, fractional_bits=10):
        # 保存参数，方便 testbench 访问
        self.width_num = width_num
        self.width_den = width_den
        self.fractional_bits = fractional_bits

        self.start = Signal()
        self.busy = Signal()
        self.done = Signal()
        self.num = Signal((width_num, True))
        self.den = Signal((width_den, True))
        self.quotient = Signal((width_num, True))
        # 流水线迭代次数必须覆盖被放大后的所有位
        abs_num_width = width_num + 1
        abs_den_width = width_den + 1
        PIPELINE_STAGES = abs_num_width + fractional_bits
        INTERNAL_NUM_WIDTH = abs_num_width + fractional_bits  # 被除数在内部的位宽

        # 符号处理（使用扩展位宽避免最小负数取反溢出）
        n_abs = Signal((abs_num_width, False))
        d_abs = Signal((abs_den_width, False))
        n_sign = Signal()
        d_sign = Signal()
        q_sign = Signal()

        num_ext = Signal((abs_num_width, True))
        den_ext = Signal((abs_den_width, True))

        self.comb += [
            n_sign.eq(self.num[-1]),
            d_sign.eq(self.den[-1]),
            num_ext.eq(Cat(self.num, self.num[-1])),
            den_ext.eq(Cat(self.den, self.den[-1])),
            n_abs.eq(Mux(n_sign, -num_ext, num_ext)),
            d_abs.eq(Mux(d_sign, -den_ext, den_ext)),
            q_sign.eq(n_sign ^ d_sign),
        ]

        # 流水线寄存器
        r = [Signal((abs_den_width + 1, False)) for _ in range(PIPELINE_STAGES + 1)]
        quo = [Signal((INTERNAL_NUM_WIDTH, False)) for _ in range(PIPELINE_STAGES + 1)]
        q = [Signal((INTERNAL_NUM_WIDTH, False)) for _ in range(PIPELINE_STAGES + 1)]
        d = [Signal.like(d_abs) for _ in range(PIPELINE_STAGES + 1)]
        v = [Signal() for _ in range(PIPELINE_STAGES + 1)]

        # 输入级：把被除数左移 fractional_bits（放大）
        n_abs_scaled = Signal((INTERNAL_NUM_WIDTH, False))
        self.comb += n_abs_scaled.eq(n_abs << fractional_bits)

        self.sync += [
            If(self.start,
               r[0].eq(0),
               q[0].eq(n_abs_scaled),
               d[0].eq(d_abs),
               quo[0].eq(0),
               v[0].eq(1)
               ).Else(
                v[0].eq(0)
            )
        ]

        # 主流水线（恢复/试商）
        for i in range(PIPELINE_STAGES):
            r_in = r[i]
            q_in = q[i]
            d_in = d[i]
            v_in = v[i]
            quo_in = quo[i]

            r_out = r[i + 1]
            q_out = q[i + 1]
            d_out = d[i + 1]
            v_out = v[i + 1]
            quo_out = quo[i + 1]

            # 移位：把 q_in 的最高位移入 r 的最低位左边
            r_shifted = Cat(q_in[-1], r_in[0:abs_den_width])
            q_shifted = (q_in << 1) & ((1 << INTERNAL_NUM_WIDTH) - 1)  # 保持位宽

            # 减法
            r_sub = Signal((abs_den_width + 1, False))
            self.comb += r_sub.eq(r_shifted - d_in)

            # 如果 r_sub 的最高位 (符号位) 为 0 表示非负 => 减法成功
            sub_success = Signal()
            self.comb += sub_success.eq(r_sub[abs_den_width] == 0)

            # 更新寄存器
            self.sync += [
                v_out.eq(v_in),
                q_out.eq(q_shifted),
                d_out.eq(d_in),
                If(v_in,
                   If(sub_success,
                      r_out.eq(r_sub),
                      quo_out.eq((quo_in << 1) | 1)
                      ).Else(
                       r_out.eq(r_shifted),
                       quo_out.eq(quo_in << 1)
                   )
                   )
            ]

        # 输出级：我们只关心最终的 quo（包含小数位）
        q_final_unsigned = quo[PIPELINE_STAGES]

        # q_final_unsigned 宽度为 INTERNAL_NUM_WIDTH，但外部期望输出宽度为 width_num
        # 取低 width_num 位作为最终输出（包含 fractional bits）
        q_final_trunc = Signal((width_num, False))
        self.comb += q_final_trunc.eq(q_final_unsigned[0:width_num])

        # 写回输出
        self.sync += [
            self.done.eq(v[PIPELINE_STAGES]),
            If(v[PIPELINE_STAGES],
               self.quotient.eq(Mux(q_sign, -q_final_trunc, q_final_trunc))
               )
        ]

        # busy = pipeline 中任意一级为有效
        self.comb += self.busy.eq(reduce(or_, v))
