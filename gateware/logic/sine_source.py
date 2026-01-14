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

from math import pi, sin

from migen import Array, Constant, Module, Signal
from misoc.interconnect.csr import AutoCSR, CSRStorage

class SineSource(Module, AutoCSR):
    def __init__(
        self,
        width=14,
        phase_bits=32,
        lut_bits=10,
        clk_freq=125_000_000,
        sine_freq=10_000,
        amplitude_scale=0.5,
    ):
        phase_inc = int(round(sine_freq * (1 << phase_bits) / clk_freq))
        max_amplitude = (1 << (width - 1)) - 1
        amplitude_scale = max(0.0, min(1.0, float(amplitude_scale)))
        amplitude = int(round(max_amplitude * amplitude_scale))
        table_size = 1 << lut_bits

        lut = Array(
            Constant(
                int(round(max_amplitude * sin(2 * pi * idx / table_size))),
                (width, True),
            )
            for idx in range(table_size)
        )

        self.output = Signal((width, True))

        self.phase_inc = CSRStorage(phase_bits, reset=phase_inc, name="phase_inc")
        self.amplitude = CSRStorage(width, reset=amplitude, name="amplitude")

        phase = Signal(phase_bits)
        index = Signal(lut_bits)
        base = Signal((width, True))
        product = Signal((width * 2, True))
        scaled = Signal((width, True))

        self.sync += phase.eq(phase + self.phase_inc.storage)
        self.comb += [
            index.eq(phase[phase_bits - lut_bits :]),
            base.eq(lut[index]),
            product.eq(base * self.amplitude.storage),
            scaled.eq(product >> (width - 1)),
            self.output.eq(scaled),
        ]