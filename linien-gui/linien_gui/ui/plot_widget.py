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

# pyqt signals enforce type, so...
INVALID_POWER = -1000


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

        self._should_reposition_reset_view_button = False
        self.error_signal_history = deque(maxlen=N_POINTS)

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

        self.parameters.to_plot.add_callback(self.on_new_plot_data_received)
        self.parameters.automatic_mode.add_callback(self.on_automatic_mode_changed)

        self._configure_simple_view()

        def _configure_simple_view(self) -> None:
            self.errorSignal1.setVisible(False)
            self.errorSignal2.setVisible(False)
            self.monitorSignal.setVisible(False)
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
            self.controlSignal: Color.CONTROL_SIGNAL,
            self.controlSignalHistory: Color.CONTROL_SIGNAL_HISTORY,
            self.slowHistory: Color.SLOW_HISTORY,
            self.monitorSignalHistory: Color.MONITOR_SIGNAL_HISTORY,
        }.items():
            r, g, b, _ = getattr(self.app.settings, f"plot_color_{color.value}").value
            a = self.app.settings.plot_line_opacity.value
            curve.setPen(pg.mkPen((r, g, b, a), width=pen_width))

    def on_lock_changed(self, *args) -> None:
        self.setLabel("bottom", "sample", units="")

    def on_new_plot_data_received(self, to_plot):
        time_beginning = time()

        if self._should_reposition_reset_view_button:
            self._should_reposition_reset_view_button = False
            self.position_reset_view_button()

        if time_beginning - self.last_plot_time <= self.plot_rate_limit:
            # don't plot too often as it only causes unnecessary load
            return

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
            to_plot = pickle.loads(to_plot)

            if to_plot is None:
                return

            if not check_plot_data(to_plot):
                return
            error_signal = to_plot.get("error_signal")
            power_signal = to_plot.get("power_signal")

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
            if power_signal is not None:
                self.signal_power1.emit(float(np.mean(power_signal)))
            else:
                self.signal_power1.emit(INVALID_POWER)

        time_end = time()
        time_diff = time_end - time_beginning
        new_rate_limit = 2 * time_diff

        if new_rate_limit < DEFAULT_PLOT_RATE_LIMIT:
            new_rate_limit = DEFAULT_PLOT_RATE_LIMIT

        self.plot_rate_limit = new_rate_limit


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
