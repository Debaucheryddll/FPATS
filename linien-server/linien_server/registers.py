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

from typing import Optional

import numpy as np
import rpyc
from linien_common.common import FilterType, MHz, convert_channel_mixing_value
from linien_common.config import ACQUISITION_PORT, DEFAULT_SWEEP_SPEED
from linien_server.parameters import Parameters

from linien_server import csrmap
from linien_server.iir_coeffs import make_filter


class Registers:
    """
    This class provides low-level access to the FPGA registers.

    High-level applications should not access this class directly but instead
    communicate by manipulating `Parameters` / `RemoteParameters`.
    """

    def __init__(
        self,
        control,
        parameters: Parameters,
        host: Optional[str] = None,
    ) -> None:
        self.control = control
        self.parameters = parameters

        if host is None:
            # AcquisitionService is imported only on the Red Pitaya since pyrp3 is not
            # available on Windows
            from linien_server.acquisition import AcquisitionService

            self.acquisition = AcquisitionService()
        else:
            # AcquisitionService has to be started manually on the Red Pitaya
            self.acquisition = rpyc.connect(host, ACQUISITION_PORT).root

        self._last_sweep_speed = None
        self._last_raw_acquisition_settings = None
        self._iir_cache: dict[str, tuple[list[float], list[float]]] = {}

        self.parameters.lock.add_callback(self.acquisition.exposed_set_lock_status)
        self.parameters.fetch_additional_signals.add_callback(
            self.acquisition.exposed_set_fetch_additional_signals, call_immediately=True
        )
        self.parameters.dual_channel.add_callback(
            self.acquisition.exposed_set_dual_channel, call_immediately=True
        )

    def write_registers(self):
        """Writes data from `parameters` to the FPGA."""

        def max_(val):
            return val if np.abs(val) <= 8191 else (8191 * val / np.abs(val))

        def phase_to_delay(phase):
            return int(phase / 360 * (1 << 14))

        if not self.parameters.dual_channel.value:
            factor_a = 256
            factor_b = 0
        else:
            factor_a, factor_b = convert_channel_mixing_value(
                self.parameters.channel_mixing.value
            )

        lock_changed = self.parameters.lock.value != self.control.exposed_is_locked
        self.control.exposed_is_locked = self.parameters.lock.value

        new = dict(
            # sweep run is 1 by default. The gateware automatically takes care of
            # stopping the sweep run after `request_lock` is set by setting
            # `sweep.clear`
            # logic_sweep_run=1,
            # logic_sweep_pause=int(self.parameters.sweep_pause.value),
            # logic_sweep_step=int(
            #     DEFAULT_SWEEP_SPEED
            #     * self.parameters.sweep_amplitude.value
            #     / (2**self.parameters.sweep_speed.value)
            # ),
            # # NOTE: Sweep center is set by `logic_out_offset`.
            # logic_sweep_min=-1 * max_(self.parameters.sweep_amplitude.value * 8191),
            # logic_sweep_max=max_(self.parameters.sweep_amplitude.value * 8191),
            logic_mod_freq=(
                self.parameters.modulation_frequency.value
                if not self.parameters.pid_only_mode.value
                else 0
            ),
            logic_mod_amp=(
                self.parameters.modulation_amplitude.value
                if (self.parameters.modulation_frequency.value > 0)
                and (not self.parameters.pid_only_mode.value)
                else 0
            ),
            # logic_dual_channel=int(self.parameters.dual_channel.value),
            logic_pid_only_mode=int(self.parameters.pid_only_mode.value),
            logic_chain_a_factor=factor_a,
            logic_chain_b_factor=factor_b,
            logic_chain_a_offset=twos_complement(
                int(self.parameters.offset_a.value), 14
            ),
            logic_chain_b_offset=twos_complement(
                int(self.parameters.offset_b.value), 14
            ),
            logic_out_offset=int(self.parameters.sweep_center.value * 8191),
            logic_combined_offset=twos_complement(
                self.parameters.combined_offset.value, 14
            ),
            logic_analog_out_1=self.parameters.analog_out_1.value,
            logic_analog_out_2=self.parameters.analog_out_2.value,
            logic_analog_out_3=self.parameters.analog_out_3.value,
            sine_source_phase_inc=int(self.parameters.sine_source_frequency.value),
            sine_source_amplitude=int(self.parameters.sine_source_amplitude.value),
            kalman_targets_power_threshold_target_cmd=int(
                self.parameters.scan_power_threshold.value
            ),

            # channel A
            fast_a_demod_delay=(
                phase_to_delay(self.parameters.demodulation_phase_a.value)
                if (self.parameters.modulation_frequency.value > 0)
                and (not self.parameters.pid_only_mode.value)
                else 0
            ),
            fast_a_demod_multiplier=self.parameters.demodulation_multiplier_a.value,
            fast_a_dx_sel=csrmap.signals.index("zero"),
            fast_a_y_tap=2,
            fast_a_dy_sel=csrmap.signals.index("zero"),
            fast_a_invert=int(self.parameters.invert_a.value),
            # channel B
            fast_b_demod_delay=(
                phase_to_delay(self.parameters.demodulation_phase_b.value)
                if (self.parameters.modulation_frequency.value > 0)
                and (not self.parameters.pid_only_mode.value)
                else 0
            ),
            fast_b_demod_multiplier=self.parameters.demodulation_multiplier_b.value,
            fast_b_dx_sel=csrmap.signals.index("zero"),
            fast_b_y_tap=2,
            fast_b_dy_sel=csrmap.signals.index("zero"),
            fast_b_invert=int(self.parameters.invert_b.value),
            # trigger on sweep
            scopegen_external_trigger=1,
            gpio_p_oes=0b11111111,
            gpio_n_oes=0b11111111,
            gpio_p_outs=self.parameters.gpio_p_out.value,
            gpio_n_outs=self.parameters.gpio_n_out.value,
            gpio_n_do0_en=csrmap.signals.index("zero"),
            gpio_n_do1_en=csrmap.signals.index("zero"),
            logic_slow_decimation=16,
        )


        if self.parameters.lock.value:
            # display combined error signal and control signal
            new.update(
                {
                    "scopegen_adc_a_sel": csrmap.signals.index(
                        "err_calc_out_e"
                    ),
                    "scopegen_adc_a_q_sel": csrmap.signals.index(
                        "err_calc_power_signal_out"
                    ),
                    "scopegen_adc_b_sel": csrmap.signals.index("logic_control_signal"),
                    "scopegen_adc_b_q_sel": csrmap.signals.index("zero"),
                }
            )
        else:
            # display both demodulated error signals (if dual channel mode) OR: display
            # demodulated error signal 1 + monitor signal
            new.update(
                {
                    # "scopegen_adc_a_sel": csrmap.signals.index("fast_a_out_i"),
                    "scopegen_adc_a_sel": csrmap.signals.index("err_calc_out_e"),
                    "scopegen_adc_a_q_sel": csrmap.signals.index("fast_a_out_q"),
                    "scopegen_adc_b_sel": csrmap.signals.index(
                        "fast_b_out_i"
                        if self.parameters.dual_channel.value
                        else "fast_b_x"
                    ),
                    "scopegen_adc_b_q_sel": csrmap.signals.index(
                        "fast_b_out_q" if self.parameters.dual_channel.value else "zero"
                    ),
                }
            )

        # filter out values that did not change
        new = dict(
            (k, v)
            for k, v in new.items()
            if (
                (k not in self.control._cached_data)
                or (self.control._cached_data.get(k) != v)
            )
        )
        self.control._cached_data.update(new)

        # pass sweep speed changes to acquisition process
        sweep_changed = self.parameters.sweep_speed.value != self._last_sweep_speed
        if sweep_changed:
            self._last_sweep_speed = self.parameters.sweep_speed.value
            self.acquisition.exposed_set_sweep_speed(self.parameters.sweep_speed.value)

        raw_acquisition_settings = (
            self.parameters.acquisition_raw_enabled.value,
            self.parameters.acquisition_raw_decimation.value,
        )
        if raw_acquisition_settings != self._last_raw_acquisition_settings:
            self._last_raw_acquisition_settings = raw_acquisition_settings
            self.acquisition.exposed_set_raw_acquisition(*raw_acquisition_settings)

        fpga_base_freq = 125e6


        for k, v in new.items():
            self.set(k, int(v))

        kp = self.parameters.p.value
        ki = self.parameters.i.value
        kd = self.parameters.d.value
        slope = self.parameters.target_slope_rising.value
        control_channel, sweep_channel, slow_control_channel = (
            self.parameters.control_channel.value,
            self.parameters.sweep_channel.value,
            self.parameters.slow_control_channel.value,
        )

        def channel_polarity(channel):
            return (
                self.parameters.polarity_fast_out1.value,
                self.parameters.polarity_fast_out2.value,
                self.parameters.polarity_analog_out0.value,
            )[channel]

        if control_channel != sweep_channel:
            if channel_polarity(control_channel) != channel_polarity(sweep_channel):
                slope = not slope

        slow_strength = (
            self.parameters.pid_on_slow_strength.value
            if self.parameters.pid_on_slow_enabled.value
            else 0
        )
        slow_slope = (
            1
            if channel_polarity(slow_control_channel)
            == channel_polarity(control_channel)
            else -1
        )

        for chain in ("a", "b"):
            automatic = getattr(self.parameters, f"filter_automatic_{chain}").value
            # iir_idx means iir_c or iir_d
            for iir_idx in range(2):
                # iir_sub_idx means in-phase signal or quadrature signal
                for iir_sub_idx in range(2):
                    iir_name = (
                        f"fast_{chain}_iir_{('c', 'd')[iir_idx]}_{iir_sub_idx + 1}"
                    )

                    if automatic:
                        filter_enabled = True
                        filter_type = FilterType.LOW_PASS
                        filter_frequency = (
                            self.parameters.modulation_frequency.value / MHz * 1e6 / 2
                        )

                        # if the filter frequency is too low (< 10Hz), the IIR doesn't
                        # work properly anymore. In that case, don't filter. This is
                        # also helpful if the raw (not demodulated) signal should be
                        # displayed which can be achieved by setting modulation
                        # frequency to 0.
                        if filter_frequency < 10:
                            filter_enabled = False
                    else:
                        filter_enabled = getattr(
                            self.parameters, f"filter_{iir_idx + 1}_enabled_{chain}"
                        ).value
                        filter_type = getattr(
                            self.parameters, f"filter_{iir_idx + 1}_type_{chain}"
                        ).value
                        filter_frequency = getattr(
                            self.parameters, f"filter_{iir_idx + 1}_frequency_{chain}"
                        ).value

                    if not filter_enabled:
                        self.set_iir(iir_name, *make_filter("P", k=1))
                    else:
                        if filter_type == FilterType.LOW_PASS:
                            self.set_iir(
                                iir_name,
                                *make_filter(
                                    "LP", f=filter_frequency / fpga_base_freq, k=1
                                ),
                            )
                        elif filter_type == FilterType.HIGH_PASS:
                            self.set_iir(
                                iir_name,
                                *make_filter(
                                    "HP", f=filter_frequency / fpga_base_freq, k=1
                                ),
                            )
                        else:
                            raise Exception(
                                f"Unknown filter {filter_type} for {iir_name}"
                            )

        if lock_changed and not self.parameters.lock.value:
            self.set_pid(kp, ki, kd, slope, reset=1, request_lock=0)
        else:
            self.set_pid(kp, ki, kd, slope, reset=0)
            # self.set_slow_pid(slow_strength, slow_slope)

    def set_pid(self, p, i, d, slope, reset=None, request_lock=None):

        sign = -1 if slope else 1
        self.set("logic_pid_kp", p * sign)
        self.set("logic_pid_ki", i * sign)
        self.set("logic_pid_kd", d * sign)

        if reset is not None:
            self.set("logic_pid_reset", reset)

    # def set_slow_pid(self, strength, slope, reset=None):
    #     sign = slope
    #     self.set("slow_chain_pid_ki", strength * sign)
    #
    #     if reset is not None:
    #         self.set("slow_chain_pid_reset", reset)

    def read_csr(self, key: str) -> int:
        if hasattr(self.acquisition, "csr"):
            return int(self.acquisition.csr.get(key))
        return int(self.acquisition.exposed_get_csr(key))



    def read_error_signal(self) -> int:
        """Return the latest error-signal sample from ``err_calc.error_signal`` CSR.

        The CSR is defined by ``ErrorSignalCalculator`` in
        ``gateware/logic/errorsignalcalculator_1.py`` and exposed in the map as
        ``err_calc_out_e``.
        """
        return self.read_csr("err_calc_out_e")

    def read_power_signal(self) -> int:
        """Return the latest power sample from ``err_calc.power_signal_out`` CSR.
        The CSR is defined by ``ErrorSignalCalculator`` in
        ``gateware/logic/errorsignalcalculator_1.py`` and exposed in the map as
        ``err_calc_power_signal_out``.
        """
        return self.read_csr("err_calc_power_signal_out")

    def read_scan_tracker_fsm_state(self) -> int:
        """Return the current scan-tracking FSM state."""

        return self.read_csr("scan_tracker_fsm_state")

    def read_scan_tracker_time_command(self) -> int:
        """Return the latest scan-tracking time command output."""

        return self.read_csr("scan_tracker_time_command_out")

    def read_scan_tracker_status(self) -> dict[str, int]:
        """Return a snapshot of the scan-tracking controller status.

        This helper fetches the FSM state and the time-command output exposed by
        the PL-side ``ScanTrackingController`` CSRs (``fsm_state_status`` and
        ``time_command_out_status`` in ``gateware/logic/scan_tracking.py``),
        allowing PS services to monitor PL tracking behavior.
        """
        return {
            "fsm_state": self.read_scan_tracker_fsm_state(),
            "time_command_out": self.read_scan_tracker_time_command(),
        }

    def write_csr(self, key: str, value: int) -> None:
        if hasattr(self.acquisition, "csr"):
            self.acquisition.csr.set(key, int(value))
        else:
            self.acquisition.exposed_set_csr(key, int(value))

    def write_kalman_targets(
            self,
            x_target: int,
            f_target: int,
            time_uncertainty: int,
            power_threshold: int,
    ) -> None:
        """Store Kalman-derived setpoints into the PL CSRs."""

        self.write_csr("kalman_targets_x_target_cmd", x_target)
        self.write_csr("kalman_targets_f_target_cmd", f_target)
        self.write_csr("kalman_targets_t_target_cmd", time_uncertainty)
        self.write_csr("kalman_targets_power_threshold_target_cmd", power_threshold)


    def set(self, key, value):
        self.acquisition.exposed_set_csr(key, value)

    def set_iir(self, iir_name: str, b: list[float], a: list[float]) -> None:
        if self._iir_cache.get(iir_name) != (b, a):
            # as setting iir parameters takes some time, take care that we don't  do it
            # too often
            self.acquisition.exposed_set_iir_csr(iir_name, b, a)
            self._iir_cache[iir_name] = (b, a)


def twos_complement(num: int, N_bits: int) -> int:
    max_ = 1 << (N_bits - 1)
    full = 2 * max_
    if num < 0:
        num += full
    return num
