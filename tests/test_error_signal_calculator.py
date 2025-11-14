import math
from migen import *
from migen.sim import run_simulation
from gateware.logic.error_signal_calculator import ErrorSignalCalculator

def test_error_signal_calculator():
    class TB(Module):
        def __init__(self):
            self.submodules.calculator = ErrorSignalCalculator(width=25, fractional_bits=20)
            self.test_vectors = [
                (10000, 0, 5000, 0),
                (5000, 5000, 5000, 5000),
                (12345, 6789, 9876, 4321),
                (-10000, 0, 5000, 0),
                (0, 0, 0, 0)
            ]
            self.results = []

        def bench_process(self):
            for ia, qa, ib, qb in self.test_vectors:
                yield self.calculator.i_a.eq(ia)
                yield self.calculator.q_a.eq(qa)
                yield self.calculator.i_b.eq(ib)
                yield self.calculator.q_b.eq(qb)
                yield

                # start 脉冲
                yield self.calculator.divider.start.eq(1)
                yield
                yield self.calculator.divider.start.eq(0)

                # 等待流水线完成
                for _ in range(self.calculator.divider.width_num + self.calculator.divider.fractional_bits + 2):
                    yield

                out_e = (yield self.calculator.out_e)
                self.results.append((ia, qa, ib, qb, out_e))
                yield

    tb = TB()
    run_simulation(tb, tb.bench_process(), vcd_name="error_signal_calculator.vcd")

    # 输出结果
    for ia, qa, ib, qb, out_e in tb.results:
        mag_a = math.sqrt(ia*ia + qa*qa)
        mag_b = math.sqrt(ib*ib + qb*qb)
        ref = 0 if mag_a + mag_b == 0 else (mag_a - mag_b)/(mag_a + mag_b)
        out_e_f = out_e / (2**20)
        print(f"Ia={ia}, Qa={qa}, Ib={ib}, Qb={qb} => out_e={out_e_f:.8f}, ref={ref:.8f}")
        assert abs(out_e_f - ref) < 0.01, f"out_e mismatch: {out_e_f} vs {ref}"
