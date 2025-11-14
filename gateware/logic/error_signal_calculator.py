from migen import *
from gateware.logic.divider_1 import PipelinedFloatDivider
from gateware.logic.cordic import Cordic

class ErrorSignalCalculator(Module):
    """
    E = (|V1| - |V2|) / (|V1| + |V2|)
    """
    def __init__(self, width=25, fractional_bits=20):
        self.i_a = Signal((width, True))
        self.q_a = Signal((width, True))
        self.i_b = Signal((width, True))
        self.q_b = Signal((width, True))
        self.out_e = Signal((width, True))

        # --- 内部信号 ---
        mag_a = Signal((width, True))
        mag_b = Signal((width, True))

        # --- CORDIC 计算幅值 ---
        self.submodules.cordic_a = Cordic(width=width, cordic_mode="vector", func_mode="circular", eval_mode="combinatorial")
        self.submodules.cordic_b = Cordic(width=width, cordic_mode="vector", func_mode="circular", eval_mode="combinatorial")

        self.comb += [
            self.cordic_a.xi.eq(self.i_a),
            self.cordic_a.yi.eq(self.q_a),
            mag_a.eq(self.cordic_a.xo),
            self.cordic_b.xi.eq(self.i_b),
            self.cordic_b.yi.eq(self.q_b),
            mag_b.eq(self.cordic_b.xo)
        ]

        numerator = Signal((width, True))
        denominator = Signal((width, True))

        self.comb += [
            numerator.eq(mag_a - mag_b),
            denominator.eq(Mux((mag_a + mag_b) == 0, 1, mag_a + mag_b))
        ]

        # --- 定点除法器 ---
        self.submodules.divider = PipelinedFloatDivider(width_num=width, width_den=width, fractional_bits=fractional_bits)

        # 单周期 start 脉冲
        start_pulse = Signal()
        start_reg = Signal()
        self.sync += start_reg.eq(start_pulse)
        self.comb += start_pulse.eq(~start_reg)

        self.sync += [
            self.divider.num.eq(numerator),
            self.divider.den.eq(denominator),
            self.divider.start.eq(start_pulse)
        ]

        self.comb += [
            If(self.divider.done,
               self.out_e.eq(self.divider.quotient)
            ).Else(
               self.out_e.eq(self.out_e)
            )
        ]
