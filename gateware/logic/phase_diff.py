# This file is part of Linien and based on redpid.
#
# Copyright (C) 2016-2024 Linien Authors (https://github.com/linien-org/linien#license)
#
# Linien is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Linien is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Linien.  If not, see <http://www.gnu.org/licenses/>.

from migen import Module, Signal
from misoc.interconnect.csr import AutoCSR, CSRStatus

from gateware.logic.cordic import Cordic


class PhaseDiffCalculator(Module, AutoCSR):
    def __init__(self, width=25):
        self.i_a = Signal((width, True))
        self.q_a = Signal((width, True))
        self.i_b = Signal((width, True))
        self.q_b = Signal((width, True))

        beat_width = width * 2 + 2
        self.phase_diff = Signal((beat_width, True))
        self.csr_phase_diff = CSRStatus(beat_width, name="phase_diff")

        w_real = Signal((beat_width, True))
        w_imag = Signal((beat_width, True))

        self.submodules.cordic = Cordic(
            width=beat_width,
            stages=beat_width,
            guard=2,
            eval_mode="pipelined",
            cordic_mode="vector",
            func_mode="circular",
        )

        self.comb += [
            w_real.eq((self.i_a * self.i_b) + (self.q_a * self.q_b)),
            w_imag.eq((self.q_a * self.i_b) - (self.i_a * self.q_b)),
            self.cordic.xi.eq(w_real),
            self.cordic.yi.eq(w_imag),
            self.cordic.zi.eq(0),
            self.phase_diff.eq(self.cordic.zo),
            self.csr_phase_diff.status.eq(self.phase_diff),
        ]
