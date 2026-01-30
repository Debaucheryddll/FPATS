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

from migen import If, Module, Signal
from misoc.interconnect.csr import AutoCSR, CSRStorage

from .cordic import Cordic


class DemodulationFrequencyLock(Module, AutoCSR):
    def __init__(self, freq_width=32, width=14):
        # input signal
        self.x = Signal((width, True))

        # demodulated signals (i and q)
        self.i = Signal((width, True))
        self.q = Signal((width, True))

        # demodulation configuration
        self.delay = CSRStorage(freq_width, name="delay")
        self.multiplier = CSRStorage(4, reset=1, name="multiplier")
        self.phase = Signal(width)

        # frequency lock configuration (driven by external CSRs)
        self.dfl_enable = Signal()
        self.dfl_gain = Signal(4)
        self.dfl_phase_to_freq_shift = Signal(5)
        self.dfl_smooth_shift = Signal(4)

        # internal state
        self.prev_i = Signal((width, True))
        self.prev_q = Signal((width, True))

        beat_width = width * 2 + 2
        self.beat_r = Signal((beat_width, True))
        self.beat_i = Signal((beat_width, True))
        self.phase_diff = Signal((beat_width, True))

        self.freq_error = Signal((freq_width, True))
        self.freq_error_filtered = Signal((freq_width, True))
        self.phase_correction_acc = Signal((freq_width, True))

        self.submodules.cordic = Cordic(
            width=width + 1,
            stages=width + 1,
            guard=2,
            eval_mode="pipelined",
            cordic_mode="rotate",
            func_mode="circular",
        )
        self.submodules.phase_cordic = Cordic(
            width=beat_width,
            stages=beat_width,
            guard=2,
            eval_mode="pipelined",
            cordic_mode="vector",
            func_mode="circular",
        )

        phase_correction = Signal(width)
        phase_sum = Signal((width + 1, True))
        phase_with_correction = Signal(width)

        freq_error_step = Signal((beat_width + 4, True))

        self.comb += [
            phase_correction.eq(self.phase_correction_acc[-len(phase_correction) :]),
            phase_sum.eq(self.phase + phase_correction),
            phase_with_correction.eq(phase_sum[-len(phase_with_correction) :]),
            # cordic input
            self.cordic.xi.eq(self.x),
            self.cordic.zi.eq(
                ((phase_with_correction * self.multiplier.storage) + self.delay.storage)
                << 1
            ),
            # cordic output
            self.i.eq(self.cordic.xo >> 1),
            self.q.eq(self.cordic.yo >> 1),
            # beat detection
            self.beat_r.eq((self.i * self.prev_i) + (self.q * self.prev_q)),
            self.beat_i.eq((self.q * self.prev_i) - (self.i * self.prev_q)),
            self.phase_cordic.xi.eq(self.beat_r),
            self.phase_cordic.yi.eq(self.beat_i),
            self.phase_cordic.zi.eq(0),
            self.phase_diff.eq(self.phase_cordic.zo),
            freq_error_step.eq(self.phase_diff << self.dfl_gain),
            self.freq_error.eq(
                (freq_error_step >> self.dfl_phase_to_freq_shift)[-freq_width:]
            ),
        ]

        correction_delta = Signal((freq_width, True))
        smoothed_delta = Signal((freq_width, True))

        self.comb += [
            correction_delta.eq(self.freq_error - self.freq_error_filtered),
            smoothed_delta.eq(correction_delta >> self.dfl_smooth_shift),
        ]

        self.sync += [
            self.prev_i.eq(self.i),
            self.prev_q.eq(self.q),
            If(
                self.dfl_enable,
                self.freq_error_filtered.eq(self.freq_error_filtered + smoothed_delta),
                self.phase_correction_acc.eq(
                    self.phase_correction_acc + self.freq_error_filtered
                ),
            ).Else(
                self.freq_error_filtered.eq(0),
                self.phase_correction_acc.eq(0),
            ),
        ]