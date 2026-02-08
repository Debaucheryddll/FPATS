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

import csv
import logging
import pickle
import subprocess
from datetime import datetime
from pathlib import Path
from random import random
from threading import Event, Thread
from time import sleep
from typing import Any, Optional

import numpy as np
from linien_common.common import DECIMATION, MAX_N_POINTS
from linien_common.config import ACQUISITION_PORT
from linien_server import csrmap
from linien_server.csr import PythonCSR
from linien_server.tracking.fixed_point_utils import FixedPointConverter
from pyrp3.board import RedPitaya  # type: ignore
from pyrp3.instrument import TriggerSource  # type: ignore
from rpyc import Service
from rpyc.utils.server import ThreadedServer

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

POWER_FRAC_BITS = 10
POWER_DENOM_THRESHOLD = 4
DEMOD_IIR_NOISE_GATE_THRESHOLD = 32


def _to_signed(value: int, width: int) -> int:
    sign_bit = 1 << (width - 1)
    if value & sign_bit:
        return value - (1 << width)
    return value


def _fixed_to_float(
    value: int, width: int, fractional_bits: int = POWER_FRAC_BITS
) -> float:
    return FixedPointConverter.fixed_to_float(value, width, fractional_bits)

def _phase_to_degrees(value: int, width: int) -> float:
    return (value * 180.0) / (1 << (width - 1))

def _clamp_unsigned(value: int, width: int) -> int:
    mask = (1 << width) - 1
    return max(0, min(value, mask))

def _clamp_signed(value: int, limit: int) -> int:
    return max(-limit, min(value, limit))

def _split_power_by_error_raw(
    power_raw: int, error_raw: int, fractional_bits: int = POWER_FRAC_BITS
) -> tuple[int, int]:
    power_width = csrmap.csr["err_calc_power_signal_out"][2]
    power_raw = power_raw & ((1 << power_width) - 1)
    if power_raw <= POWER_DENOM_THRESHOLD:
        return 0, 0
    error_limit = 1 << fractional_bits
    error_raw = max(-error_limit, min(error_raw, error_limit))
    scaled_error_power = (power_raw * error_raw) >> fractional_bits
    power_a_raw = _clamp_unsigned((power_raw + scaled_error_power) // 2, power_width)
    power_b_raw = _clamp_unsigned((power_raw - scaled_error_power) // 2, power_width)
    return power_a_raw, power_b_raw


def _split_power_by_error(
    power_raw: int, error_raw: int, fractional_bits: int = POWER_FRAC_BITS
) -> tuple[float, float]:
    power_width = csrmap.csr["err_calc_power_signal_out"][2]
    power_a_raw, power_b_raw = _split_power_by_error_raw(
        power_raw, error_raw, fractional_bits
    )
    return (
        FixedPointConverter.fixed_to_unsigned_float(
            power_a_raw, power_width, fractional_bits
        ),
        FixedPointConverter.fixed_to_unsigned_float(
            power_b_raw, power_width, fractional_bits
        ),
    )


def _has_csr(name: str) -> bool:
    return name in csrmap.csr


def _get_signed_csr(csr: PythonCSR, name: str) -> int | None:
    if not _has_csr(name):
        return None
    return _to_signed(int(csr.get(name)), csrmap.csr[name][2])


def _get_signed_from_raw(name: str, raw_values: dict[str, int]) -> int | None:
    if name not in raw_values or not _has_csr(name):
        return None
    return _to_signed(int(raw_values[name]), csrmap.csr[name][2])



class AcquisitionService(Service):
    def __init__(self) -> None:
        super(AcquisitionService, self).__init__()
        stop_nginx()       # 停止redpitaya板子上自带的程序
        flash_fpga()       # 将本控制程序烧入FPGA中进行控制

        self.red_pitaya = RedPitaya() # 实例化一个板子对象，是pyrp3库所提供的功能
        self.csr = PythonCSR(self.red_pitaya)
        self.csr_queue: list[tuple[str, int]] = []
        self.csr_iir_queue: list[tuple[str, list[float], list[float]]] = []

        self.data: bytes | None = pickle.dumps(None)
        self.data_was_raw = False
        self.data_hash: float | None = None
        self.data_uuid: float | None = None
        self.power_samples: list[tuple[str, float, float, float]] = []

        self.locked = False
        self.exposed_set_sweep_speed(9)

        self.fetch_additional_signals = True
        self.raw_acquisition_enabled = False
        self.raw_acquisition_decimation = 0

        self.dual_channel = False
        self.read_from_csr = True

        self.stop_event = Event()
        self.pause_event = Event()
        self.skip_next_data_event = Event()
        self.slow_data_cache: dict[str, int | float | None] = {}
        self.slow_data_dirty = True
        self.program_acquisition_and_rearm()

        self.thread = Thread(
            target=self._acquisition_loop,
            args=(
                self.stop_event,
                self.pause_event,
                self.skip_next_data_event,
            ),
            daemon=True,
        )
        self.thread.start()

    def _acquisition_loop(
        self, stop_event: Event, pause_event: Event, skip_next_data_event: Event
    ) -> None:
        while not stop_event.is_set():
            had_csr_updates = False
            while self.csr_queue:
                key, value = self.csr_queue.pop(0)
                self.csr.set(key, value)
                had_csr_updates = True

            while self.csr_iir_queue:
                name, b, a = self.csr_iir_queue.pop(0)
                self.csr.set_iir(name, b, a)
                had_csr_updates = True

            if had_csr_updates:
                self.slow_data_dirty = True


            if pause_event.is_set():
                sleep(0.001)
                continue

            if self.read_from_csr:
                data = self.read_data()
                is_raw = False
            else:
                # check that scope is triggered; copied from
                # https://github.com/RedPitaya/RedPitaya/blob/14cca62dd58f29826ee89f4b28901602f5cdb1d8/api/src/oscilloscope.c#L115  # noqa: E501
                if not (self.red_pitaya.scope.read(0x1 << 2) & 0x4) <= 0:
                    sleep(0.001)
                    continue

                if self.raw_acquisition_enabled:
                    data_raw = self.read_data_raw(
                        0x10000,
                        self.red_pitaya.scope.write_pointer_trigger,
                        MAX_N_POINTS,
                    )
                    is_raw = True
                else:
                    data = self.read_data()
                    is_raw = False

            if pause_event.is_set():
                # it may seem strange that we check this here a second time. Reason:
                # `read_data` takes some time and if in the mean time acquisition
                # was paused, we do not want to send the data
                continue

            if skip_next_data_event.is_set():
                skip_next_data_event.clear()
            else:
                if self.raw_acquisition_enabled:
                    self.data = pickle.dumps(data_raw)
                else:
                    self.data = pickle.dumps(data)
                self.data_was_raw = is_raw
                self.data_hash = random()

    def _read_slow_data(self, power_a_raw: int, power_b_raw: int) -> dict[str, int | float | None]:
        slow_keys = [
            "scan_tracker_fsm_state",
            "scan_tracker_power_level",
            "scan_tracker_power_threshold_acquire",
            "kalman_targets_power_threshold_target_cmd",
            "logic_pid_setpoint",
            "logic_pid_kp",
            "logic_pid_ki",
            "logic_pid_kd",
        ]
        slow_raw = self.csr.get_many(slow_keys)

        scan_tracker_state = int(slow_raw["scan_tracker_fsm_state"])
        scan_tracker_power_level = FixedPointConverter.fixed_to_unsigned_float(
            int(slow_raw["scan_tracker_power_level"]),
            csrmap.csr["scan_tracker_power_level"][2],
            POWER_FRAC_BITS,
        )
        scan_tracker_power_threshold = FixedPointConverter.fixed_to_unsigned_float(
            int(slow_raw["scan_tracker_power_threshold_acquire"]),
            csrmap.csr["scan_tracker_power_threshold_acquire"][2],
            POWER_FRAC_BITS,
        )
        kalman_power_threshold = int(
            slow_raw["kalman_targets_power_threshold_target_cmd"]
        )
        pid_setpoint = _get_signed_from_raw("logic_pid_setpoint", slow_raw)
        pid_kp = _get_signed_from_raw("logic_pid_kp", slow_raw)
        pid_ki = _get_signed_from_raw("logic_pid_ki", slow_raw)
        pid_kd = _get_signed_from_raw("logic_pid_kd", slow_raw)
        return {
            "scan_tracker_state": scan_tracker_state,
            "scan_tracker_power_level": scan_tracker_power_level,
            "scan_tracker_power_threshold_acquire": scan_tracker_power_threshold,
            "kalman_power_threshold": kalman_power_threshold,
            "pid_setpoint": pid_setpoint,
            "pid_kp": pid_kp,
            "pid_ki": pid_ki,
            "pid_kd": pid_kd,
        }

    def read_data(self) -> dict[str, int | float | None]:
        fast_keys = [
            "err_calc_out_e",
            "err_calc_power_signal_out",
            # "logic_control_signal",
            # "scan_tracker_time_command_out",
            # "kalman_targets_x_target_cmd",
            # "kalman_targets_f_target_cmd",
            # "kalman_targets_t_target_cmd",
        ]
        raw_values = self.csr.get_many(fast_keys)

        error_signal = _get_signed_from_raw("err_calc_out_e", raw_values)
        if error_signal is None:
            raise KeyError("err_calc_out_e")
        error_signal = _clamp_signed(error_signal, 1 << POWER_FRAC_BITS)
        power_signal_raw = int(raw_values["err_calc_power_signal_out"])
        power_signal = FixedPointConverter.fixed_to_unsigned_float(
            power_signal_raw, csrmap.csr["err_calc_power_signal_out"][2], POWER_FRAC_BITS
        )
        power_a_raw, power_b_raw = _split_power_by_error_raw(
            power_signal_raw, error_signal
        )
        power_signal_a, power_signal_b = _split_power_by_error(
            power_signal_raw, error_signal
        )
        # control_signal = _get_signed_from_raw("logic_control_signal", raw_values)
        # if control_signal is None:
        #     raise KeyError("logic_control_signal")
        # scan_tracker_time = _get_signed_csr(self.csr, "scan_tracker_time_command_out")
        # scan_tracker_time = _get_signed_from_raw(
        #     "scan_tracker_time_command_out", raw_values
        # )
        # kalman_x = _get_signed_from_raw("kalman_targets_x_target_cmd", raw_values)
        # kalman_f = _get_signed_from_raw("kalman_targets_f_target_cmd", raw_values)
        # kalman_t = _get_signed_from_raw("kalman_targets_t_target_cmd", raw_values)
        if self.slow_data_dirty or not self.slow_data_cache:
            self.slow_data_cache = self._read_slow_data(power_a_raw, power_b_raw)
            self.slow_data_dirty = False
        data = {
            "error_signal": error_signal,
            "power_signal": power_signal,
            "power_signal_a": power_signal_a,
            "power_signal_b": power_signal_b,
            # "control_signal": control_signal,
            # "scan_tracker_time_command_out": scan_tracker_time,
            # "kalman_x_target": kalman_x,
            # "kalman_f_target": kalman_f,
            # "kalman_t_target": kalman_t,
        }
        data.update(self.slow_data_cache)
        timestamp = datetime.utcnow().isoformat()
        self.power_samples.append(
            (timestamp, power_signal, power_signal_a, power_signal_b)
        )
        return data

    def read_data_raw(
        self, offset: int, addr: int, data_length: int
    ) -> tuple[Any, ...]:
        max_data_length = 16383
        if data_length + addr > max_data_length:
            to_read_later = data_length + addr - max_data_length
            data_length -= to_read_later
        else:
            to_read_later = 0
        raw_data = self.red_pitaya.scope.reads(offset + (4 * addr), data_length).copy()
        # raw data contains two signals:
        #   2'h0,adc_b_rd,2'h0,adc_a_rd
        #   i.e.: 2 zero bits, channel b (14 bit), 2 zero bits, channel a (14 bit)
        # .copy() is required, because np.frombuffer returns a readonly array
        # 原数据来源于scope模块，FPGA内存中的数据是32位整数的数组。每一个32位整数都像一个“集装箱”
        # 里面并排打包了两个14位的ADC采样值（通道A和通道B），以及一些填充位，32位结构: {2'b0, adc_b[13:0], 2'b0, adc_a[13:0]}
        # raw_data is an array of 32-bit ints. We cast it to 16 bit --> each original
        # int is split into two ints
        raw_data.dtype = np.int16

        # sign bit is at position 14, but we have 16 bit ints
        raw_data[raw_data >= 2**13] -= 2**14

        # order is such that we have first the signal a then signal b
        # 将交错排列的数据分离成两个独立的通道
        signals = tuple(raw_data[signal_idx::2] for signal_idx in (0, 1))

        if to_read_later > 0:
            additional_raw_data = self.read_data_raw(offset, 0, to_read_later)
            signals = tuple(
                np.append(signals[signal_idx], additional_raw_data[signal_idx])
                for signal_idx in (0, 1)
            )

        return signals

    def program_acquisition_and_rearm(self, trigger_delay=16384):
        # 为下一次数据采集动态地配置FPGA的硬件参数，这部分代码根据系统当前的三种不同工作状态
        # # 智能地设置FPGA示波器（ScopeGen）的数据抽取率，三种情况如下：
        # 情况一：if not self.locked: (未锁定 / 扫描模式)
        # 配置: data_decimation的值是根据扫描速度(self.sweep_speed)动态计算出来的。
        # 目的: 这是一个自适应设计。当扫描速度很快时，需要一个较高的抽取率（较低的采样率），以确保一次完整的扫描能够被完整地记录在ScopeGen有限的内存中。
        # 当扫描速度很慢时，则使用较低的抽取率（较高的采样率），以获得更高分辨率的光谱数据
        # 情况二： elif self.raw_acquisition_enabled: (原始采集模式)
        # 配置: data_decimation的值直接由self.raw_acquisition_decimation这个参数决定。
        # 目的: 这个模式是专门为PSD噪声分析设计的。PSDAcquisition模块会轮流设置不同的抽取率，以便在不同的频率范围内测量噪声谱，这个分支就是执行PSDAcquisition模块下达的配置指令
        # 情况三： else: (已锁定模式)
        # 配置: data_decimation被固定为1。
        # 代表不进行任何抽取，即以FPGA能达到的最高采样率进行数据采集。这在锁定状态下非常有用，因为它提供了最高的时间分辨率，让您可以精细地观察和分析反馈环路的动态性能和高频噪声。
        """Program the acquisition settings and rearm acquisition."""
        if self.raw_acquisition_enabled:
            self.red_pitaya.scope.data_decimation = 1
            self.red_pitaya.scope.trigger_delay = int(trigger_delay / DECIMATION) - 1
        else:
            target_decimation = 1
            self.red_pitaya.scope.data_decimation = target_decimation
            self.red_pitaya.scope.trigger_delay = int(trigger_delay / DECIMATION) - 1

        self.red_pitaya.scope.rearm(trigger_source=TriggerSource.ext_posedge)

    def exposed_return_data(self, last_hash: Optional[float]) -> tuple[
        bool,
        float | None,
        bool | None,
        bytes | None,
        float | None,
    ]:
        no_data_available = self.data_hash is None
        data_not_changed = self.data_hash == last_hash
        if data_not_changed or no_data_available or self.pause_event.is_set():
            return False, None, None, None, None
        else:
            return True, self.data_hash, self.data_was_raw, self.data, self.data_uuid

    def exposed_set_sweep_speed(self, speed):
        self.sweep_speed = speed

    def exposed_set_lock_status(self, locked: bool) -> None:
        self.locked = locked


    def exposed_set_fetch_additional_signals(self, fetch: bool) -> None:
        self.fetch_additional_signals = fetch

    def exposed_set_raw_acquisition(self, enabled: bool, decimation: int) -> None:
        self.raw_acquisition_enabled = enabled
        self.raw_acquisition_decimation = decimation

    def exposed_set_dual_channel(self, dual_channel):
        self.dual_channel = dual_channel

    def exposed_get_csr(self, key: str) -> int:
        return int(self.csr.get(key))

    def exposed_set_csr(self, key: str, value: int) -> None:
        self.csr_queue.append((key, value))
        self.slow_data_dirty = True

    def exposed_set_iir_csr(self, name: str, b: list[float], a: list[float]) -> None:
        self.csr_iir_queue.append((name, b, a))
        self.slow_data_dirty = True

    def exposed_stop_acquisition(self) -> None:
        self.stop_event.set()
        self.thread.join()
        if self.power_samples:
            output_dir = Path("/usr/share/plot_data")
            output_dir.mkdir(parents=True, exist_ok=True)
            filename = f"{datetime.utcnow():%Y%m%d_%H%M%S_%f}.csv"
            output_path = output_dir / filename
            with output_path.open("w", newline="") as csv_file:
                writer = csv.writer(csv_file)
                writer.writerow(
                    [
                        "timestamp_utc",
                        "power_signal",
                        "power_signal_a",
                        "power_signal_b",
                    ]
                )
                writer.writerows(self.power_samples)
            self.power_samples.clear()
        start_nginx()

    def exposed_pause_acquisition(self):
        self.pause_event.set()
        self.data_hash = None
        self.data = None

    def exposed_continue_acquisition(self, uuid: Optional[float]) -> None:
        # resetting data here is not strictly required but we want to be on the safe
        # side
        self.data_hash = None
        self.data = None
        self.pause_event.clear()
        self.data_uuid = uuid
        # if we are sweeping, we have to skip one data set because an incomplete sweep
        # may have been recorded. When locked, this does not matter
        if self.locked:
            self.skip_next_data_event.clear()
        else:
            self.skip_next_data_event.set()

def flash_fpga():
    filepath = Path(__file__).resolve().parent / "gateware.bin"
    logger.info("Using fpgautil to deploy gateware.")
    subprocess.Popen(["/opt/redpitaya/bin/fpgautil", "-b", str(filepath)]).wait()


def start_nginx():
    subprocess.Popen(["systemctl", "start", "redpitaya_nginx.service"])


def stop_nginx():
    subprocess.Popen(["systemctl", "stop", "redpitaya_nginx.service"]).wait()
    subprocess.Popen(["systemctl", "stop", "redpitaya_scpi.service"]).wait()


if __name__ == "__main__":
    threaded_server = ThreadedServer(AcquisitionService(), port=ACQUISITION_PORT)
    logger.info(f"Starting AcquisitionService on port {ACQUISITION_PORT}")
    threaded_server.start()
