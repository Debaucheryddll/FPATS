from migen import If, Module, Signal
from misoc.interconnect.csr import AutoCSR, CSRStatus

from gateware.logic.cordic import Cordic
from gateware.logic.divider_1 import PipelinedFloatDivider


class ErrorSignalCalculator(Module, AutoCSR):
    """
    Compute E = (|V1| - |V2|) / (|V1| + |V2|).

    This version uses a CORDIC magnitude estimate for |V1| and |V2|, matching the
    paper's intent more closely than the previous "I^2 + Q^2 high bits" shortcut.
    """

    def __init__(self, width=25, fractional_bits=10):
        self.i_a = Signal((width, True))
        self.q_a = Signal((width, True))
        self.i_b = Signal((width, True))
        self.q_b = Signal((width, True))
        self.out_e = Signal((width, True))
        self.power_signal_out = Signal(width, name="power_signal_out")
        self.power_a_out = Signal(width, name="power_a_out")
        self.power_b_out = Signal(width, name="power_b_out")
        self.power_signal_full_out = Signal((2 * width + 1), name="power_signal_full_out")

        self.signal_in = []
        self.signal_out = [self.out_e, self.power_signal_out, self.power_signal_full_out]
        self.state_in = []
        self.state_out = []

        self.csr_out_e = CSRStatus(width, name="out_e")
        self.csr_power_signal_out = CSRStatus(width, name="power_signal_out")
        self.csr_power_a_out = CSRStatus(width, name="power_a_out")
        self.csr_power_b_out = CSRStatus(width, name="power_b_out")
        self.csr_power_signal_full_out = CSRStatus(
            (2 * width + 1), name="power_signal_full_out"
        )

        # Leave one guard bit before the CORDIC gain (~1.647) is applied.
        cordic_input_shift = 1

        mag_a = Signal((width, True))
        mag_b = Signal((width, True))
        mag_a_scaled = Signal(width)
        mag_b_scaled = Signal(width)

        self.submodules.mag_a_cordic = Cordic(
            width=width,
            widthz=width,
            guard=2,
            eval_mode="pipelined",
            cordic_mode="vector",
            func_mode="circular",
        )
        self.submodules.mag_b_cordic = Cordic(
            width=width,
            widthz=width,
            guard=2,
            eval_mode="pipelined",
            cordic_mode="vector",
            func_mode="circular",
        )

        ia_sq = Signal((2 * width, True))
        qa_sq = Signal((2 * width, True))
        ib_sq = Signal((2 * width, True))
        qb_sq = Signal((2 * width, True))
        pa_wide = Signal((2 * width + 1, True))
        pb_wide = Signal((2 * width + 1, True))

        self.comb += [
            self.mag_a_cordic.xi.eq(self.i_a >> cordic_input_shift),
            self.mag_a_cordic.yi.eq(self.q_a >> cordic_input_shift),
            self.mag_a_cordic.zi.eq(0),
            self.mag_b_cordic.xi.eq(self.i_b >> cordic_input_shift),
            self.mag_b_cordic.yi.eq(self.q_b >> cordic_input_shift),
            self.mag_b_cordic.zi.eq(0),
            ia_sq.eq(self.i_a * self.i_a),
            qa_sq.eq(self.q_a * self.q_a),
            ib_sq.eq(self.i_b * self.i_b),
            qb_sq.eq(self.q_b * self.q_b),
            pa_wide.eq(ia_sq + qa_sq),
            pb_wide.eq(ib_sq + qb_sq),
        ]

        # The vectoring CORDIC should return a non-negative magnitude. Clamp any
        # spurious negative value to zero to avoid corrupting the normalization.
        self.comb += [
            If(self.mag_a_cordic.xo < 0, mag_a.eq(0)).Else(mag_a.eq(self.mag_a_cordic.xo)),
            If(self.mag_b_cordic.xo < 0, mag_b.eq(0)).Else(mag_b.eq(self.mag_b_cordic.xo)),
            mag_a_scaled.eq(mag_a),
            mag_b_scaled.eq(mag_b),
        ]

        numerator = Signal((width, True))
        denominator = Signal(width)
        denominator_wide = Signal(width + 1)
        mag_a_signed = Signal((width, True))
        mag_b_signed = Signal((width, True))

        denominator_threshold = 4
        noise_floor_threshold = 32
        safe_to_divide = Signal()
        error_limit = Signal((width, True))

        self.comb += [
            mag_a_signed.eq(mag_a_scaled),
            mag_b_signed.eq(mag_b_scaled),
            error_limit.eq(1 << fractional_bits),
            numerator.eq(mag_a_signed - mag_b_signed),
            denominator_wide.eq(mag_a_scaled + mag_b_scaled),
        ]
        self.comb += [
            If(
                denominator_wide[width],
                denominator.eq((1 << width) - 1),
            ).Else(
                denominator.eq(denominator_wide[:width]),
            ),
            safe_to_divide.eq(denominator > denominator_threshold),
        ]

        self.submodules.divider = PipelinedFloatDivider(
            width_num=width,
            width_den=width,
            fractional_bits=fractional_bits,
        )

        start_en = Signal()
        self.comb += start_en.eq(safe_to_divide)
        self.comb += [
            self.divider.start.eq(start_en),
            self.divider.num.eq(numerator),
            self.divider.den.eq(denominator),
        ]

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
                    denominator > noise_floor_threshold,
                    self.out_e.eq(limited_quotient),
                ).Else(
                    self.out_e.eq(0),
                ),
            ).Elif(~safe_to_divide & ~self.divider.busy, self.out_e.eq(0))
        ]

        denominator_reg = Signal(width)
        power_full_reg = Signal((2 * width + 1))
        self.sync += [
            denominator_reg.eq(denominator),
            # Keep the wide power monitor as a sum of squared magnitudes for
            # diagnostics while switching the control path to true |V|.
            power_full_reg.eq(pa_wide + pb_wide),
        ]
        self.comb += [
            self.csr_out_e.status.eq(self.out_e),
            self.csr_power_signal_out.status.eq(denominator_reg),
            self.power_signal_out.eq(denominator_reg),
            self.csr_power_a_out.status.eq(mag_a_scaled),
            self.power_a_out.eq(mag_a_scaled),
            self.csr_power_b_out.status.eq(mag_b_scaled),
            self.power_b_out.eq(mag_b_scaled),
            self.csr_power_signal_full_out.status.eq(power_full_reg),
            self.power_signal_full_out.eq(power_full_reg),
        ]
