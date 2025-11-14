#
# 【新文件】: gateware/logic/pipelined_divider.py
#
# 这是一个Migen实现的、可综合的、支持有符号数的
# N位流水线恢复除法器。
#

from migen import Module, Signal, Cat, Array, Mux, If
from functools import reduce
from operator import or_

class PipelinedDivider(Module):
    """
    流水线 N位 有符号恢复除法器

    在 `start` 信号拉高一个周期后，开始计算。
    经过 N+2 个时钟周期后，`done` 信号会拉高一个周期，
    此时 `quotient` (商) 和 `remainder` (余数) 上的结果有效。

    属性 (Attributes):
    ----------
    start (Signal, 1-bit, In):
        脉冲信号，用于启动一次新的除法运算。
    busy (Signal, 1-bit, Out):
        在计算过程中保持高电平。
    done (Signal, 1-bit, Out):
        计算完成时，拉高一个时钟周期。

    num (Signal, N-bit signed, In):
        分子 (被除数)。
    den (Signal, N-bit signed, In):
        分母 (除数)。

    quotient (Signal, N-bit signed, Out):
        计算结果：商 (Q)。
    remainder (Signal, N-bit signed, Out):
        计算结果：余数 (R)。
    """

    def __init__(self, width=25):
        # --- 1. 声明输入/输出接口 ---
        self.start = Signal()
        self.busy = Signal()
        self.done = Signal()

        self.num = Signal((width, True))  # 分子
        self.den = Signal((width, True))  # 分母

        self.quotient = Signal((width, True))  # 商
        self.remainder = Signal((width, True))  # 余数

        # --- 2. 内部逻辑 ---

        # --- 2a. 输入预处理 (处理符号) ---
        n_reg = Signal.like(self.num)
        d_reg = Signal.like(self.den)

        # 将有符号输入转为无符号（取绝对值）
        n_abs = Signal.like(self.num)
        d_abs = Signal.like(self.den)
        n_sign = Signal()
        d_sign = Signal()

        # 最终商的符号 (q_sign = n_sign XOR d_sign)
        q_sign = Signal()

        self.comb += [
            n_sign.eq(self.num[-1]),  # 获取分子的符号位
            d_sign.eq(self.den[-1]),  # 获取分母的符号位

            # 如果是负数，取反码+1
            n_abs.eq(Mux(n_sign, -self.num, self.num)),
            d_abs.eq(Mux(d_sign, -self.den, self.den)),

            # 异或运算决定最终商的符号
            q_sign.eq(n_sign ^ d_sign)
        ]

        # --- 2b. 定义流水线寄存器 ---

        # r: 存放 部分余数 (Partial Remainder)。需要 N+1 位宽来处理溢出。
        # q: 存放 分子 和 逐步生成的商。
        # d: 逐级传递分母。
        # v: 逐级传递“有效”标志。

        r = [Signal((width + 1, False)) for _ in range(width + 1)]
        q = [Signal((width, False)) for _ in range(width + 1)]
        d = [Signal.like(d_abs) for _ in range(width + 1)]
        v = [Signal() for _ in range(width + 1)]  # "valid" bit pipeline

        # --- 2c. 流水线第0级 (输入锁存) ---
        self.sync += [
            If(self.start,
               r[0].eq(0),  # 初始余数 R = 0
               q[0].eq(n_abs),  # 锁存分子的绝对值
               d[0].eq(d_abs),  # 锁存分母的绝对值
               v[0].eq(1)  # 启动流水线
               ).Else(
                v[0].eq(0)
            )
        ]

        # --- 2d. 流水线第1级 到 第N级 (核心算法) ---
        for i in range(width):
            r_in = r[i]
            q_in = q[i]
            d_in = d[i]
            v_in = v[i]

            r_out = r[i + 1]
            q_out = q[i + 1]
            d_out = d[i + 1]
            v_out = v[i + 1]

            # 1. 将 (R, Q) 逻辑左移一位
            #    r_shifted 的最高位是来自q_in的最高位
            r_shifted = Cat(q_in[-1], r_in[0:width])
            q_shifted = Cat(Signal(1), q_in[0:width - 1])  # Q << 1, LSB补0

            # 2. 尝试用 (R << 1) 减去 D
            r_sub = Signal.like(r_in)
            self.comb += r_sub.eq(r_shifted - d_in)

            # 3. 检查减法是否成功 (结果是否为正)
            sub_success = Signal()
            self.comb += sub_success.eq(r_sub[width] == 0)  # 检查最高位(符号位)

            # 4. 根据结果更新下一级的寄存器
            self.sync += [
                If(sub_success,  # 如果 R - D >= 0 (成功)
                   r_out.eq(r_sub),  # 新的余数 R = R - D
                   q_out.eq(q_shifted | 1)  # 商的最低位(LSB)置 1
                   ).Else(  # 否则 (R - D < 0) (失败)
                    r_out.eq(r_shifted),  # 保持 R 不变 (恢复)
                    q_out.eq(q_shifted)  # 商的最低位(LSB)保持 0
                ),
                d_out.eq(d_in),  # 将分母传递给下一级
                v_out.eq(v_in)  # 将“有效”位传递给下一级
            ]

        # --- 2e. 输出级 (处理符号) ---
        q_final_unsigned = q[width]
        # 最终的余数是第N级流水线上的 r_out，并且要截断到width位
        r_final_unsigned = r[width][0:width]

        # 锁存最终的符号化结果
        self.sync += [
            self.done.eq(v[width]),  # 'done' 信号在流水线末端产生
            If(v[width],  # 当数据到达流水线末端时
               # 根据之前算好的符号，决定是输出正数还是负数
               self.quotient.eq(Mux(q_sign, -q_final_unsigned, q_final_unsigned)),
               # 余数的符号与被除数(分子)的符号保持一致
               self.remainder.eq(Mux(n_sign, -r_final_unsigned, r_final_unsigned))
               )
        ]

        # busy 信号是流水线中任何一级“有效”位的“或”运算
        self.comb += self.busy.eq(reduce(or_, v))