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

from linien_common.common import OutputChannel
from migen import (
    Array,
    Cat,
    ClockDomain,
    ClockDomainsRenamer,
    If,
    Module,
    Mux,
    Signal,
    bits_for,
)
from misoc.interconnect import csr_bus
from misoc.interconnect.csr import AutoCSR, CSRStatus, CSRStorage

from gateware.logic.chains import FastChain, SlowChain, cross_connect
from gateware.logic.decimation import Decimate
from gateware.logic.KalmanTargets import KalmanTargets
from gateware.logic.delta_sigma import DeltaSigma
from gateware.logic.errorsignalcalculator_1 import ErrorSignalCalculator
from gateware.logic.scan_tracking import ScanTrackingController
from gateware.logic.sine_source import SineSource

from gateware.logic.limit import LimitCSR
from gateware.logic.modulate import Modulate
from gateware.logic.pid import PID
from gateware.lowlevel.analog import PitayaAnalog
from gateware.lowlevel.crg import CRG
from gateware.lowlevel.dna import DNA
from gateware.lowlevel.gpio import Gpio
from gateware.lowlevel.pitaya_ps import PitayaPS, Sys2CSR, SysCDC, SysInterconnect
from gateware.lowlevel.scopegen import ScopeGen
from gateware.lowlevel.xadc import XADC



class LinienLogic(Module, AutoCSR):
    def __init__(self, width=14, signal_width=25, chain_factor_width=8, coeff_width=25):
        self.init_csr(width, chain_factor_width)
        self.init_submodules(width, signal_width)

    def init_csr(self, width, chain_factor_width):
        self.pid_only_mode = CSRStorage(1,name="pid_only_mode")
        # we use chain_factor_width + 1 for the single channel mode
        factor_reset = 1 << (chain_factor_width - 1)
        self.chain_a_factor = CSRStorage(chain_factor_width + 1, reset=factor_reset,name="chain_a_factor")
        self.chain_b_factor = CSRStorage(chain_factor_width + 1, reset=factor_reset,name="chain_b_factor")
        self.chain_a_offset = CSRStorage(width,name="chain_a_offset")
        self.chain_b_offset = CSRStorage(width,name="chain_b_offset")
        self.combined_offset = CSRStorage(width,name="combined_offset")
        self.combined_offset_signed = Signal((width, True),name="combined_offset_signed")
        self.out_offset = CSRStorage(width,name="out_offset")
        self.slow_decimation = CSRStorage(bits_for(16),name="slow_decimation")
        for i in range(1, 4):
            setattr(self, f"analog_out_{i}", CSRStorage(15, name=f"analog_out_{i}"))
        self.slow_value = CSRStatus(width,name="slow_value")
        self.chain_a_offset_signed = Signal((width, True))
        self.chain_b_offset_signed = Signal((width, True))
        self.out_offset_signed = Signal((width, True))

        self.signal_in = []
        self.signal_out = []
        self.state_in = []
        self.state_out = []


    def init_submodules(self, width, signal_width):
        self.submodules.mod = Modulate(width=width)
        self.submodules.limit_error_signal = LimitCSR(width=signal_width, guard=4)
        self.submodules.limit_fast1 = LimitCSR(width=width, guard=5)
        self.submodules.limit_fast2 = LimitCSR(width=width, guard=5)
        self.submodules.pid = PID(width=signal_width)
        self.control_signal = Signal((width, True), name="control_signal")
        self.signal_out = [self.control_signal]

class LinienModule(Module, AutoCSR):
    def __init__(self, platform):
        width = 14
        signal_width = 25
        coeff_width = 25
        chain_factor_bits = 8

        self.init_submodules(
            width, signal_width, coeff_width, chain_factor_bits, platform
        )
        self.connect_everything(width, signal_width, coeff_width, chain_factor_bits)

    def init_submodules(
        self, width, signal_width, coeff_width, chain_factor_bits, platform
    ):
        sys_double = ClockDomainsRenamer("sys_double")

        self.submodules.logic = LinienLogic(
            coeff_width=coeff_width, chain_factor_width=chain_factor_bits
        )
        self.submodules.analog = PitayaAnalog(
            platform.request("adc"), platform.request("dac")
        )
        self.submodules.xadc = XADC(platform.request("xadc"))

        for i in range(4):
            pwm = platform.request("pwm", i)
            ds = sys_double(DeltaSigma(width=15))
            self.comb += pwm.eq(ds.out)
            setattr(self.submodules, f"ds{i}", ds)

        exp = platform.request("exp")
        self.submodules.gpio_n = Gpio(exp.n)
        self.submodules.gpio_p = Gpio(exp.p)

        leds = Cat(*(platform.request("user_led", i) for i in range(8)))
        self.comb += leds.eq(self.gpio_n.o)

        self.submodules.dna = DNA(version=2)

        self.submodules.fast_a = FastChain(
            width,
            signal_width,
            coeff_width,
            self.logic.mod,
            offset_signal=self.logic.chain_a_offset_signed,
        )
        self.submodules.fast_b = FastChain(
            width,
            signal_width,
            coeff_width,
            self.logic.mod,
            offset_signal=self.logic.chain_b_offset_signed,
        )

        _ = ClockDomainsRenamer("sys_slow")
        # sys_double = ClockDomainsRenamer("sys_double")
        # max_decimation = 16
        # self.submodules.decimate = sys_double(Decimate(max_decimation))
        # self.clock_domains.cd_decimated_clock = ClockDomain()
        # decimated_clock = ClockDomainsRenamer("decimated_clock")
        # self.submodules.slow_chain = decimated_clock(SlowChain())
        self.submodules.err_calc = ErrorSignalCalculator(width=signal_width)
        # 实例化 KalmanTargets 模块
        self.submodules.kalman_targets = KalmanTargets(width=signal_width)
        self.submodules.scan_tracker = ScanTrackingController(width=signal_width)
        self.submodules.scopegen = ScopeGen(signal_width)
        self.submodules.sine_source = SineSource(width=width, amplitude_scale=0.5)

        self.state_names, self.signal_names = cross_connect(
            self.gpio_n,
            [
                ("fast_a", self.fast_a),
                ("fast_b", self.fast_b),
                ("err_calc", self.err_calc),
                ("scopegen", self.scopegen),
                ("logic", self.logic),
                ("scan_tracker", self.scan_tracker),
            ],
        )

        csr_map = {
            "dna": 28,
            "xadc": 29,
            "gpio_n": 30,
            "gpio_p": 31,
            "fast_a": 0,
            "fast_b": 1,
            "err_calc":9,
            "scopegen": 6,
            "noise": 7,
            "logic": 8,
            "kalman_targets": 10,
            "scan_tracker": 11,
        }

        self.submodules.csrbanks = csr_bus.CSRBankArray(
            self,
            lambda name, mem: csr_map[
                name if mem is None else name + "_" + mem.name_override
            ],
        )
        self.submodules.sys2csr = Sys2CSR()
        self.submodules.csrcon = csr_bus.Interconnect(
            self.sys2csr.csr, self.csrbanks.get_buses()
        )
        self.submodules.syscdc = SysCDC()
        self.comb += self.syscdc.target.connect(self.sys2csr.sys)

    def connect_everything(self, width, signal_width, coeff_width, chain_factor_bits):
        s = signal_width - width

        self.comb += [
            self.fast_a.adc.eq(self.analog.adc_a),
            self.fast_b.adc.eq(self.analog.adc_b),
        ]

        self.comb += [
            # 将FastChain A的 I, Q 输出连接到计算器的输入
            self.err_calc.i_a.eq(self.fast_a.out_i),
            self.err_calc.q_a.eq(self.fast_a.out_q),
            # 将FastChain B的 I, Q 输出连接到计算器的输入
            self.err_calc.i_b.eq(self.fast_b.out_i),
            self.err_calc.q_b.eq(self.fast_b.out_q),
        ]

        # --- 连接 ScanTrackingController 的输入 ---
        self.comb += [
            # 1. 连接来自 PS (Kalman) 的估计值 (Q15.10)
            self.scan_tracker.kalman_est_time.eq(self.kalman_targets.x_target_cmd.storage),

            # 2. 连接 Kalman 的不确定性 (Q15.10)
            self.scan_tracker.kalman_est_uncertainty.eq(self.kalman_targets.t_target_cmd.storage),

            # 3. 连接 PL 的实时功率
            # 位宽适配： err_calc -> scan_tracker input
            self.scan_tracker.power_level.eq(self.err_calc.csr_power_signal_out.status),

            # 4. 连接功率阈值 (来自 PS)
            self.scan_tracker.power_threshold_acquire.eq(self.kalman_targets.power_threshold_target_cmd.storage),
        ]

        self.comb += self.logic.pid.running.eq(1)
        # FAST PID ---------------------------------------------------------------------
        pid_out = Signal((width, True))
        self.comb += [
            If(
                self.logic.pid_only_mode.storage,
                self.logic.pid.input.eq(self.scan_tracker.time_command_out << s),
            ).Else(
                # self.logic.pid.input.eq(self.err_calc.out_e),
                self.logic.pid.input.eq(0)
            ),
            pid_out.eq(self.logic.pid.pid_out >> s),
        ]

        # connect other analog outputs
        self.comb += [
            self.ds1.data.eq(self.logic.analog_out_1.storage),
            self.ds2.data.eq(self.logic.analog_out_2.storage),
            self.ds3.data.eq(self.logic.analog_out_3.storage),
        ]

        # PID 输出接入限幅器
        self.comb +=[
            self.logic.limit_fast1.x.eq(pid_out),
            self.logic.control_signal.eq(self.logic.limit_fast1.y),
            # DAC 输出来自限幅后的信号
            self.analog.dac_a.eq(self.logic.limit_fast1.y),
            self.analog.dac_b.eq(self.sine_source.output),
        ]


class DummyID(Module, AutoCSR):
    def __init__(self):
        self.id = CSRStatus(1, reset=1)


class DummyHK(Module, AutoCSR):
    def __init__(self):
        self.submodules.id = DummyID()
        self.submodules.csrbanks = csr_bus.CSRBankArray(self, lambda name, mem: 0)
        self.submodules.sys2csr = Sys2CSR()
        self.submodules.csrcon = csr_bus.Interconnect(
            self.sys2csr.csr, self.csrbanks.get_buses()
        )
        self.sys = self.sys2csr.sys


class RootModule(Module):
    def __init__(self, platform):
        self.submodules.ps = PitayaPS(platform.request("cpu"))
        self.submodules.crg = CRG(
            platform.request("clk125"), self.ps.fclk[0], ~self.ps.frstn[0]
        )
        self.submodules.linien = LinienModule(platform)

        self.submodules.hk = ClockDomainsRenamer("sys_ps")(DummyHK())

        self.submodules.ic = SysInterconnect(
            self.ps.axi.sys,
            self.hk.sys,
            self.linien.scopegen.scope_sys,
            self.linien.scopegen.asg_sys,
            self.linien.syscdc.source,
        )


