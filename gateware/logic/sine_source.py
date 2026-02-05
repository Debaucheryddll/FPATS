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

from migen import Array, Constant, Module, Signal,If
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
        self.am_phase_inc = CSRStorage(phase_bits, reset=0, name="am_phase_inc")
        self.am_amplitude = CSRStorage(width, reset=0, name="am_amplitude")
        self.pid_amplitude = CSRStorage(width, reset=0, name="pid_amplitude")
        self.fm_phase_inc = CSRStorage(phase_bits, reset=0, name="fm_phase_inc")
        self.fm_amplitude = CSRStorage(phase_bits, reset=0, name="fm_amplitude")
        self.pid_fm_amplitude = CSRStorage(phase_bits, reset=0, name="pid_fm_amplitude")
        self.pid_amplitude_input = Signal((width, True))


        phase = Signal(phase_bits)
        am_phase = Signal(phase_bits)
        fm_phase = Signal(phase_bits)
        index = Signal(lut_bits)
        am_index = Signal(lut_bits)
        fm_index = Signal(lut_bits)
        base = Signal((width, True))
        am_base = Signal((width, True))
        fm_base = Signal((width, True))
        am_amplitude_signed = Signal((width, True))
        fm_amplitude_signed = Signal((phase_bits, True))
        product = Signal((width * 2 + 1, True))
        am_product = Signal((width * 2 + 2, True))
        fm_product = Signal((phase_bits + width + 1, True))
        pid_product = Signal((width * 2, True))
        pid_fm_product = Signal((phase_bits + width, True))
        pid_scaled = Signal((width, True))
        pid_fm_scaled = Signal((phase_bits + 1, True))
        am_scaled = Signal((width, True))
        fm_scaled = Signal((phase_bits + 2, True))
        fm_scaled_trunc = Signal((phase_bits, True))
        scaled = Signal((width, True))
        amplitude_signed = Signal((width + 1, True))
        am_mod_depth_raw = Signal((width + 2, True))
        am_mod_depth = Signal((width + 2, True))
        fm_mod_depth_raw = Signal((phase_bits + 1, True))
        fm_mod_depth = Signal((phase_bits + 1, True))
        envelope = Signal((width + 1, True))
        phase_inc_mod = Signal(phase_bits)

        self.sync += [
            # phase.eq(phase + self.phase_inc.storage),
            phase.eq(phase + phase_inc_mod),
            am_phase.eq(am_phase + self.am_phase_inc.storage),
            fm_phase.eq(fm_phase + self.fm_phase_inc.storage),
        ]
        self.comb += [
            index.eq(phase[phase_bits - lut_bits:]),
            base.eq(lut[index]),
            am_index.eq(am_phase[phase_bits - lut_bits:]),
            am_base.eq(lut[am_index]),
            fm_index.eq(fm_phase[phase_bits - lut_bits:]),
            fm_base.eq(lut[fm_index]),
            am_amplitude_signed.eq(self.am_amplitude.storage),
            fm_amplitude_signed.eq(self.fm_amplitude.storage),
            pid_product.eq(self.pid_amplitude_input * self.pid_amplitude.storage),
            pid_scaled.eq(pid_product >> (width - 1)),
            pid_fm_product.eq(self.pid_amplitude_input * self.pid_fm_amplitude.storage),
            pid_fm_scaled.eq(pid_fm_product >> (width - 1)),
            am_mod_depth_raw.eq(am_amplitude_signed - pid_scaled),
            am_mod_depth.eq(am_mod_depth_raw),
            fm_mod_depth_raw.eq(fm_amplitude_signed - pid_fm_scaled),
            fm_mod_depth.eq(fm_mod_depth_raw),
            am_product.eq(am_base * am_mod_depth),
            am_scaled.eq(am_product >> (width - 1)),
            fm_product.eq(fm_base * fm_mod_depth),
            fm_scaled.eq(fm_product >> (width - 1)),
            fm_scaled_trunc.eq(fm_scaled),
            phase_inc_mod.eq(self.phase_inc.storage + fm_scaled_trunc),
            amplitude_signed.eq(self.amplitude.storage),
            envelope.eq(amplitude_signed + am_scaled),
            product.eq(base * envelope),
            scaled.eq(product >> (width - 1)),
            self.output.eq(scaled),
        ]