import pytest
from migen import *
from gateware.logic.divider_1 import PipelinedFloatDivider


class DividerTestbench(Module):
    def __init__(self, fractional_bits=10):
        self.width_num = 25
        self.fractional_bits = fractional_bits  # 动态精度
        self.submodules.div = PipelinedFloatDivider(
            width_num=self.width_num,
            width_den=25,
            fractional_bits=fractional_bits
        )

        self.results = []
        self.test_vectors = [
            (7, 2),
            (-8, 3),
            (15, -5),
            (-10, -4),
            (100, 8),
            (1, 3),
            (23, 7)
        ]

    def run_division(self, num, den):
        # 分子分母赋值，拉高 start
        yield self.div.num.eq(num)
        yield self.div.den.eq(den)
        yield self.div.start.eq(1)
        yield
        yield self.div.start.eq(0)

        # 等待流水线完成
        max_wait = self.width_num + self.fractional_bits + 5
        for _ in range(max_wait):
            done = (yield self.div.done)
            if done:
                q = (yield self.div.quotient)
                return q
            yield
        return None  # 超时返回 None

    def record_result(self, num, den, q_out):
        # q_out 是定点表示：实际浮点 = q_out / 2^fractional_bits
        real_value = q_out / float(1 << self.fractional_bits)
        expected = num / den
        self.results.append((num, den, real_value, expected))


def test_pipelined_float_divider_dynamic():
    fractional_bits = 12  # 可以修改为 6、12 等
    tb = DividerTestbench(fractional_bits=fractional_bits)

    def bench_process():
        for (num, den) in tb.test_vectors:
            q = (yield from tb.run_division(num, den))
            tb.record_result(num, den, q)

        print(f"\n=== 测试结果 (保留 {fractional_bits} 位小数) ===")
        for (num, den, out, exp) in tb.results:
            print(f"{num:>4} / {den:>4} = {out:>12.10f} (期望: {exp:>12.10f})")
            # 误差允许：1 个二进制小数位约等于 2^-fractional_bits
            max_err = 1 / (1 << fractional_bits)
            assert abs(out - exp) < max_err

    run_simulation(tb, bench_process(), vcd_name=f"pipelined_float{fractional_bits}_divider.vcd")