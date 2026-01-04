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

from migen import Cat, Module, Signal, TSTriple
from migen.genlib.cdc import MultiReg
from misoc.interconnect.csr import AutoCSR, CSRStatus, CSRStorage

# 实现了一个功能完备、安全可靠的通用I/O接口。它允许CPU对一组FPGA引脚进行完全的软件控制：
# 设置引脚方向self.oes,控制引脚输出self.outs，读取引脚输入self.ins



class Gpio(Module, AutoCSR):
    def __init__(self, pins):
        n = len(pins)
        self.i = Signal(n)
        self.o = Signal(n)
        self.ins = CSRStatus(n)
        self.outs = CSRStorage(n)
        self.oes = CSRStorage(n)

        ###

        t = [TSTriple(1) for i in range(n)]
        self.specials += [ti.get_tristate(pins[i]) for i, ti in enumerate(t)]
        self.specials += MultiReg(Cat([ti.i for ti in t]), self.i)
        self.comb += [
            Cat([ti.o for ti in t]).eq(self.outs.storage | self.o),
            Cat([ti.oe for ti in t]).eq(self.oes.storage),
            self.ins.status.eq(self.i),
        ]
