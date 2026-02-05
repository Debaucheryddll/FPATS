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


"""This file contains stuff that is required by the server as well as the client."""

from enum import IntEnum
from time import time
from typing import Dict, Iterable, List, Tuple, Union

import numpy as np

# DDS phase-increment units for a 32-bit accumulator clocked at 125 MHz.
#
# frequency_hz = phase_inc * 125e6 / 2**32
# => phase_inc_per_hz = 2**32 / 125e6
# => phase_inc_per_mhz = 2**32 / 125
Hz = (1 << 32) / 125_000_000
MHz = (1 << 32) / 125
Vpp = ((1 << 14) - 1) / 4
# conversion of bits to V
ANALOG_OUT_V = 1.8 / ((2**15) - 1)


DECIMATION = 8
MAX_N_POINTS = 16384
N_POINTS = int(MAX_N_POINTS / DECIMATION)


class FilterType(IntEnum):
    LOW_PASS = 0
    HIGH_PASS = 1


class OutputChannel(IntEnum):
    FAST_OUT1 = 0
    FAST_OUT2 = 1
    ANALOG_OUT0 = 2




class PSDAlgorithm(IntEnum):
    WELCH = 0
    LPSD = 1


def downsample_history(
    times: list, values: list, max_time_diff: float, max_N: int = N_POINTS
) -> None:
    """
    The history should not grow too much. When recording for long intervals, we want to
    throw away some datapoints that were recorded with a sampling rate that is too high.
    This function takes care of this.
    """
    last_time = None

    to_remove = []

    for idx in range(len(times)):
        current_time = times[idx]
        remove = False

        if last_time is not None:
            if np.abs(last_time - current_time) < max_time_diff / max_N:
                remove = True

        if remove:
            to_remove.append(idx)
        else:
            last_time = current_time

    for idx in reversed(to_remove):
        times.pop(idx)
        values.pop(idx)


def truncate(times, values, max_time_diff):
    while len(values) > 0:
        if time() - times[0] > max_time_diff:
            times.pop(0)
            values.pop(0)
            continue
        break


def update_signal_history(
    control_history: Dict[str, List[float]],
    monitor_history: Dict[str, List[float]],
    to_plot,

    max_time_diff: float,
) -> Union[
    Tuple[Dict[str, List[float]], Dict[str, List[float]]], Dict[str, List[float]]
]:
    if not to_plot:
        return control_history

        if "control_signal" not in to_plot:
            return control_history, monitor_history
        control_history["values"].append(np.mean(to_plot["control_signal"]))
        control_history["times"].append(time())

        if "monitor_signal" in to_plot:
            monitor_history["values"].append(np.mean(to_plot["monitor_signal"]))
            monitor_history["times"].append(time())

    # truncate
    truncate(control_history["times"], control_history["values"], max_time_diff)
    truncate(monitor_history["times"], monitor_history["values"], max_time_diff)

    # downsample
    downsample_history(
        control_history["times"], control_history["values"], max_time_diff
    )
    downsample_history(
        monitor_history["times"], monitor_history["values"], max_time_diff
    )
    return control_history, monitor_history


def convert_channel_mixing_value(value: int) -> Tuple[int, int]:
    if value <= 0:
        a_value = 128
        b_value = 128 + value
    else:
        a_value = 127 - value
        b_value = 128

    return a_value, b_value


def combine_error_signal(
    error_signals: tuple[Iterable[int], Iterable[int]],
    dual_channel: bool,
    channel_mixing: int,
    combined_offset: int,
    chain_factor_width: int = 8,
) -> np.ndarray:
    if not dual_channel:
        signal = error_signals[0]
    else:
        a_factor, b_factor = convert_channel_mixing_value(channel_mixing)

        signal = [
            (a_factor * a + b_factor * b) >> chain_factor_width
            for a, b in zip(*error_signals)
        ]

    return np.array([v + combined_offset for v in signal])


def check_plot_data(plot_data: Dict[str, np.ndarray]) -> bool:

    if "error_signal" not in plot_data:
        return False
    return True


def get_signal_strength_from_i_q(i, q):
    i = i.astype(np.int64)
    q = q.astype(np.int64)
    i_squared = i**2
    q_squared = q**2
    signal_strength = np.sqrt(i_squared + q_squared)
    return signal_strength
