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

import pickle
from time import time
from collections import deque

import numpy as np
import pyqtgraph as pg
from linien_common.common import (
    N_POINTS,
    check_plot_data,
)
from linien_gui.config import DEFAULT_PLOT_RATE_LIMIT, N_COLORS, Color
from linien_gui.utils import get_linien_app_instance
from PyQt5 import QtGui, QtWidgets
from PyQt5.QtCore import pyqtSignal
from pyqtgraph.Qt import QtCore

# NOTE: this is required for using a pen_width > 1. There is a bug though that causes
# the plot to be way too small. Therefore, we call PlotWidget.resize() after a while
pg.setConfigOptions(
    useOpenGL=True,
    # by default, pyqtgraph tries to clean some things up using atexit. This causes
    # problems with rpyc objects as their connection is already closed. Therefore, we
    # disable this cleanup.
    exitCleanup=False,
)

# relation between counts and 1V
V = 8192
FAST_IIR_SHIFT = 11

# pyqt signals enforce type, so...
INVALID_POWER = -1000
TARGET_RENDER_FPS = 100

class TimeXAxis(pg.AxisItem):
    """Plots x axis as time in seconds instead of point number."""

    def __init__(self, *args, parent=None, **kwargs):
        pg.AxisItem.__init__(self, *args, **kwargs)
        self.parent = parent
        self.app = get_linien_app_instance()
        self.app.connection_established.connect(self.on_connection_established)

    def on_connection_established(self):
        # we have to wait until parameters (of parent) is available
        QtCore.QTimer.singleShot(100, self.listen_to_parameter_changes)

    def listen_to_parameter_changes(self):
        self.on_lock_changed()

    def tickStrings(self, values, scale, spacing) -> list[str]:
        values = [scale * v for v in values]
        precision_specifier = 0
        return [f"{v:.{precision_specifier}f}" for v in values]

    def on_lock_changed(self, *args) -> None:
        self.picture = None
        self.update()


class PlotWidget(pg.PlotWidget):
    signal_power1 = pyqtSignal(float)
    signal_power2 = pyqtSignal(float)
    keyPressed = pyqtSignal(int)

    def __init__(self, *args, **kwargs):
        super(PlotWidget, self).__init__(
            *args,
            axisItems={"bottom": TimeXAxis(parent=self, orientation="bottom")},
            **kwargs,
        )
        self.app = get_linien_app_instance()
        self.app.connection_established.connect(self.on_connection_established)

        self.getAxis("bottom").enableAutoSIPrefix(False)
        self.showGrid(x=True, y=True)

        # Causes auto-scale button (‘A’ in lower-left corner) to be hidden for this
        # PlotItem
        self.hideButtons()
        # we have our own "reset view" button instead
        self.reset_view_button = QtWidgets.QPushButton(self)
        self.reset_view_button.setText("Reset view")
        self.reset_view_button.setStyleSheet("padding: 10px; font-weight: bold")
        icon = QtGui.QIcon.fromTheme("view-restore")
        self.reset_view_button.setIcon(icon)
        self.reset_view_button.clicked.connect(self.reset_view)
        self.position_reset_view_button()

        # copied from https://github.com/pyqtgraph/pyqtgraph/blob/master/pyqtgraph/graphicsItems/PlotItem/PlotItem.py#L133 # noqa: E501
        # whenever something changes, we check whether to show "auto scale" button
        self.plotItem.vb.sigStateChanged.connect(
            self.check_whether_to_show_reset_view_button
        )

        # user may zoom only as far out as there is still data
        # https://stackoverflow.com/questions/18868530/pyqtgraph-limit-zoom-to-upper-lower-bound-of-axes

        self.getViewBox().setLimits(xMin=0, xMax=2048, yMin=-1, yMax=1)

        # NOTE: increasing the pen width requires OpenGL, otherwise painting gets
        # horribly slow. See: https://github.com/pyqtgraph/pyqtgraph/issues/533
        # OpenGL is enabled in the beginning of this file.
        # NOTE: OpenGL has a bug that causes the plot to be way too small. Therefore,
        # self.resize() is called below.
        self.crosshair = pg.InfiniteLine(pos=N_POINTS / 2, pen=pg.mkPen("w", width=1))
        self.addItem(self.crosshair)

        self.zeroLine = pg.PlotCurveItem(pen=pg.mkPen("w", width=1))
        self.addItem(self.zeroLine)
        self.signalStrengthA = pg.PlotCurveItem()
        self.addItem(self.signalStrengthA)
        self.signalStrengthA2 = pg.PlotCurveItem()
        self.addItem(self.signalStrengthA2)
        self.signalStrengthAFill = pg.FillBetweenItem(
            self.signalStrengthA, self.signalStrengthA2
        )
        self.addItem(self.signalStrengthAFill)
        self.signalStrengthB = pg.PlotCurveItem()
        self.addItem(self.signalStrengthB)
        self.signalStrengthB2 = pg.PlotCurveItem()
        self.addItem(self.signalStrengthB2)
        self.signalStrengthBFill = pg.FillBetweenItem(
            self.signalStrengthB, self.signalStrengthB2
        )
        self.addItem(self.signalStrengthBFill)
        self.errorSignal1 = pg.PlotCurveItem()
        self.addItem(self.errorSignal1)
        self.errorSignal2 = pg.PlotCurveItem()
        self.addItem(self.errorSignal2)
        self.combinedErrorSignal = pg.PlotCurveItem()
        self.addItem(self.combinedErrorSignal)
        self.monitorSignal = pg.PlotCurveItem()
        self.addItem(self.monitorSignal)
        self.demodulatedIirSignalA = pg.PlotCurveItem()
        self.addItem(self.demodulatedIirSignalA)
        self.demodulatedIirSignalB = pg.PlotCurveItem()
        self.addItem(self.demodulatedIirSignalB)

        self.controlSignal = pg.PlotCurveItem()
        self.addItem(self.controlSignal)
        self.controlSignalHistory = pg.PlotCurveItem()
        self.addItem(self.controlSignalHistory)
        self.slowHistory = pg.PlotCurveItem()
        self.addItem(self.slowHistory)
        self.monitorSignalHistory = pg.PlotCurveItem()
        self.addItem(self.monitorSignalHistory)

        self.zeroLine.setData([0, N_POINTS - 1], [0, 0])
        self.errorSignal1.setData([0, N_POINTS - 1], [1, 1])
        self.errorSignal1.setData([0, N_POINTS - 1], [1, 1])
        self.combinedErrorSignal.setData([0, N_POINTS - 1], [1, 1])

        self.connection = None
        self.parameters = None
        self.last_plot_data = None
        self.plot_max = 0
        self.plot_min = np.inf

        self._fixed_opengl_bug = False

        self.last_plot_time = 0
        self.plot_rate_limit = DEFAULT_PLOT_RATE_LIMIT

        # decouple data consumption from UI rendering:
        # callbacks only cache newest frame; rendering runs at fixed FPS
        self._latest_to_plot = None
        self._has_new_plot_frame = False
        self._render_timer = QtCore.QTimer(self)
        self._render_timer.setInterval(max(1, int(1000 / TARGET_RENDER_FPS)))
        self._render_timer.timeout.connect(self.render_latest_plot_frame)
        self._render_timer.start()


        self._should_reposition_reset_view_button = False
        self.error_signal_history = deque(maxlen=N_POINTS)
        self.power_a_history = deque(maxlen=N_POINTS)
        self.power_b_history = deque(maxlen=N_POINTS)

    def on_connection_established(self):
        self.parameters = self.app.parameters
        self.control = self.app.control

        for color_idx in range(N_COLORS):
            getattr(self.app.settings, f"plot_color_{color_idx}").add_callback(
                self.on_plot_settings_changed
            )
        self.app.settings.plot_line_width.add_callback(self.on_plot_settings_changed)
        self.app.settings.plot_line_opacity.add_callback(self.on_plot_settings_changed)

        self.control_signal_history_data = self.parameters.control_signal_history.value
        self.monitor_signal_history_data = self.parameters.monitor_signal_history.value

        self.app.add_decoded_to_plot_callback(self.on_new_plot_data_received)
        self.parameters.automatic_mode.add_callback(self.on_automatic_mode_changed)

        self._configure_simple_view()

    def _configure_simple_view(self) -> None:
        self.errorSignal1.setVisible(False)
        self.errorSignal2.setVisible(False)
        self.monitorSignal.setVisible(False)
        self.demodulatedIirSignalA.setVisible(False)
        self.demodulatedIirSignalB.setVisible(False)
        self.controlSignal.setVisible(False)
        self.controlSignalHistory.setVisible(False)
        self.slowHistory.setVisible(False)
        self.monitorSignalHistory.setVisible(False)
        self.signalStrengthA.setVisible(False)
        self.signalStrengthB.setVisible(False)
        self.signalStrengthA2.setVisible(False)
        self.signalStrengthB2.setVisible(False)
        self.signalStrengthAFill.setVisible(False)
        self.signalStrengthBFill.setVisible(False)

    def _to_data_coords(self, event):
        pos = self.plotItem.vb.mapSceneToView(event.pos())
        x, y = pos.x(), pos.y()
        return x, y

    def keyPressEvent(self, event):
        # we listen here in addition to the main window because some events are only
        # caught here
        self.keyPressed.emit(event.key())


    def on_plot_settings_changed(self, *args):
        pen_width = self.app.settings.plot_line_width.value

        for curve, color in {
            self.errorSignal1: Color.ERROR1,
            self.errorSignal2: Color.ERROR2,
            self.combinedErrorSignal: Color.ERROR_COMBINED,
            self.monitorSignal: Color.MONITOR,
            self.demodulatedIirSignalA: Color.ERROR1,
            self.demodulatedIirSignalB: Color.ERROR2,
            self.controlSignal: Color.CONTROL_SIGNAL,
            self.controlSignalHistory: Color.CONTROL_SIGNAL_HISTORY,
            self.slowHistory: Color.SLOW_HISTORY,
            self.monitorSignalHistory: Color.MONITOR_SIGNAL_HISTORY,
        }.items():
            r, g, b, _ = getattr(self.app.settings, f"plot_color_{color.value}").value
            a = self.app.settings.plot_line_opacity.value
            style = (
                QtCore.Qt.DashLine
                if curve in (self.demodulatedIirSignalA, self.demodulatedIirSignalB)
                else QtCore.Qt.SolidLine
            )
            curve.setPen(pg.mkPen((r, g, b, a), width=pen_width, style=style))

    def on_lock_changed(self, *args) -> None:
        self.setLabel("bottom", "sample", units="")

    def on_automatic_mode_changed(self, *args) -> None:
        return

    def on_new_plot_data_received(self, to_plot):
        # Keep only the newest frame. This prevents the GUI from spending time
        # rendering stale data and stabilizes UI load at fixed FPS.
        self._latest_to_plot = to_plot
        self._has_new_plot_frame = True

    def render_latest_plot_frame(self):
        if not self._has_new_plot_frame:
            return

        to_plot = self._latest_to_plot
        self._has_new_plot_frame = False

        time_beginning = time()
        if self._should_reposition_reset_view_button:
            self._should_reposition_reset_view_button = False
            self.position_reset_view_button()

        self.last_plot_time = time_beginning

        # NOTE: this is necessary if OpenGL is activated. Otherwise, the plot is way too
        # small. This command apparently causes a repaint and works fine even though the
        # values are nonsense.
        if not self._fixed_opengl_bug:
            self._fixed_opengl_bug = True
            self.resize(
                self.parent().frameGeometry().width(),
                self.parent().frameGeometry().height(),
            )

        if self.parameters.pause_acquisition.value:
            return

        if to_plot is not None:
            if not isinstance(to_plot, dict):
                return

            if to_plot is None:
                return

            if not check_plot_data(to_plot):
                return
            error_signal = to_plot.get("error_signal")
            error_signal_quadrature = to_plot.get("error_signal_quadrature")
            error_signal_2 = to_plot.get("error_signal_2")
            error_signal_2_quadrature = to_plot.get("error_signal_2_quadrature")
            power_signal = to_plot.get("power_signal")
            power_signal_a = to_plot.get("power_signal_a")
            power_signal_b = to_plot.get("power_signal_b")
            monitor_signal = to_plot.get("monitor_signal")
            control_signal = to_plot.get("control_signal")

            def _as_series(signal):
                if signal is None:
                    return None
                if isinstance(signal, np.ndarray):
                    return signal
                if isinstance(signal, (list, tuple)):
                    return np.array(signal)
                return None

            def _emit_power(signal, fallback=INVALID_POWER):
                if signal is None:
                    return fallback
                if isinstance(signal, np.ndarray):
                    value = float(np.mean(signal))
                elif isinstance(signal, (list, tuple)):
                    value = float(np.mean(signal))
                else:
                    value = float(signal)
                if not np.isfinite(value) or value < 0:
                    return fallback
                return value

            def _series_or_history(signal, history):
                series = _as_series(signal)
                if series is not None and series.size > 1:
                    history.clear()
                    return series
                if signal is None:
                    return None
                if isinstance(signal, np.ndarray):
                    history.append(float(np.mean(signal)))
                elif isinstance(signal, (list, tuple)):
                    history.append(float(np.mean(signal)))
                else:
                    history.append(float(signal))
                return np.array(history)

            if isinstance(error_signal, np.ndarray) and error_signal.size > 1:
                error_series = error_signal
                self.error_signal_history.clear()
            else:
                if error_signal is None:
                    return
                self.error_signal_history.append(float(np.mean(error_signal)))
                error_series = np.array(self.error_signal_history)
            self.last_plot_data = [error_series]

            self.combinedErrorSignal.setVisible(True)
            self.combinedErrorSignal.setData(
                list(range(len(error_series))), error_series / V
            )

            error_quadrature_series = _as_series(error_signal_quadrature)
            if error_quadrature_series is not None and error_quadrature_series.size > 1:
                self.errorSignal1.setVisible(True)
                self.errorSignal1.setData(
                    list(range(len(error_quadrature_series))),
                    error_quadrature_series / V,
                )
                self.last_plot_data.append(error_quadrature_series)
            else:
                self.errorSignal1.setVisible(False)

            error2_series = _as_series(error_signal_2)
            error2_quadrature_series = _as_series(error_signal_2_quadrature)
            secondary_series = None
            if error2_series is not None and error2_series.size > 1:
                secondary_series = error2_series
            elif (
                error2_quadrature_series is not None
                and error2_quadrature_series.size > 1
            ):
                secondary_series = error2_quadrature_series

            if secondary_series is not None:
                self.errorSignal2.setVisible(True)
                self.errorSignal2.setData(
                    list(range(len(secondary_series))), secondary_series / V
                )
                self.last_plot_data.append(secondary_series)
            else:
                self.errorSignal2.setVisible(False)
            power_a_series = _series_or_history(
                power_signal_a, self.power_a_history
            )
            if (
                    self.app.settings.show_channel_a.value
                    and power_a_series is not None
                    and power_a_series.size > 1
            ):
                power_scale = (1 << FAST_IIR_SHIFT)
                self.demodulatedIirSignalA.setVisible(True)
                self.demodulatedIirSignalA.setData(
                    list(range(len(power_a_series))),
                    power_a_series / power_scale,
                )
                self.last_plot_data.append(power_a_series)
            else:
                self.demodulatedIirSignalA.setVisible(False)

            power_b_series = _series_or_history(
                power_signal_b, self.power_b_history
            )
            if (
                    self.app.settings.show_channel_b.value
                    and power_b_series is not None
                    and power_b_series.size > 1
            ):
                power_scale = (1 << FAST_IIR_SHIFT)
                self.demodulatedIirSignalB.setVisible(True)
                self.demodulatedIirSignalB.setData(
                    list(range(len(power_b_series))),
                    power_b_series / power_scale,
                )
                self.last_plot_data.append(power_b_series)
            else:
                self.demodulatedIirSignalB.setVisible(False)

            monitor_series = _as_series(monitor_signal)
            if monitor_series is not None and monitor_series.size > 1:
                self.monitorSignal.setVisible(True)
                self.monitorSignal.setData(
                    list(range(len(monitor_series))), monitor_series / V
                )
                self.last_plot_data.append(monitor_series)
            else:
                self.monitorSignal.setVisible(False)

            control_series = _as_series(control_signal)
            if control_series is not None and control_series.size > 1:
                self.controlSignal.setVisible(True)
                self.controlSignal.setData(
                    list(range(len(control_series))), control_series / V
                )
                self.last_plot_data.append(control_series)
            else:
                self.controlSignal.setVisible(False)
            if power_signal_a is not None or power_signal_b is not None:
                self.signal_power1.emit(_emit_power(power_signal_a))
                self.signal_power2.emit(_emit_power(power_signal_b))
            elif power_signal is not None:
                self.signal_power1.emit(_emit_power(power_signal))
                self.signal_power2.emit(INVALID_POWER)
            else:
                self.signal_power1.emit(INVALID_POWER)
                self.signal_power2.emit(INVALID_POWER)


    # called when widget is resized
    def position_reset_view_button(self):
        pos = QtCore.QPoint(
            self.geometry().width() - self.reset_view_button.geometry().width() - 25,
            25,
        )
        self.reset_view_button.move(pos)

    def check_whether_to_show_reset_view_button(self):
        # copied from https://github.com/pyqtgraph/pyqtgraph/blob/master/pyqtgraph/graphicsItems/PlotItem/PlotItem.py#L1195 # noqa: E501
        auto_scale_disabled = not all(self.plotItem.vb.autoRangeEnabled())
        if auto_scale_disabled:
            self.reset_view_button.show()
        else:
            self.reset_view_button.hide()

    def reset_view(self):
        self.enableAutoRange()

    def resizeEvent(self, event, *args, **kwargs):
        super().resizeEvent(event, *args, **kwargs)

        # we don't do it directly here because this causes problems for some reason
        self._should_reposition_reset_view_button = True


def scale_history_times(arr: np.ndarray, timescale: int) -> np.ndarray:
    if arr:
        arr = np.array(arr)
        arr -= arr[0]
        arr *= 1 / timescale * N_POINTS
    return arr
