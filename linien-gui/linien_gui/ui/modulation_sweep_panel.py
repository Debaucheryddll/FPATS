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

from linien_common.common import MHz, Vpp
from linien_gui.config import UI_PATH
from linien_gui.ui.spin_box import CustomDoubleSpinBox, CustomDoubleSpinBoxNoSign
from linien_gui.utils import get_linien_app_instance, param2ui
from PyQt5 import QtWidgets, uic


class ModulationAndSweepPanel(QtWidgets.QWidget):
    sweepSpeedComboBox: QtWidgets.QGroupBox
    modulation_amplitude_group = QtWidgets.QGroupBox
    modulationAmplitudeSpinBox: CustomDoubleSpinBoxNoSign
    modulation_frequency_group = QtWidgets.QGroupBox
    modulationFrequencySpinBox: CustomDoubleSpinBoxNoSign
    sine_source_group = QtWidgets.QGroupBox
    sineSourceFrequencySpinBox: CustomDoubleSpinBoxNoSign
    sineSourceAmplitudeSpinBox: CustomDoubleSpinBoxNoSign
    sineSourceAmFrequencySpinBox: CustomDoubleSpinBoxNoSign
    sineSourceAmAmplitudeSpinBox: CustomDoubleSpinBox
    spectroscopyTabs: QtWidgets.QTabWidget
    spectroscopy_channel_1_page: QtWidgets.QWidget
    spectroscopy_channel_2_page: QtWidgets.QWidget
    spectroscopyBPanelDisabled: QtWidgets.QLabel

    def __init__(self, *args, **kwargs):
        super(ModulationAndSweepPanel, self).__init__(*args, **kwargs)
        uic.loadUi(UI_PATH / "modulation_sweep_panel.ui", self)
        self.app = get_linien_app_instance()
        self.app.connection_established.connect(self.on_connection_established)

        self.modulationFrequencySpinBox.setKeyboardTracking(False)
        self.modulationFrequencySpinBox.valueChanged.connect(
            self.change_modulation_frequency
        )
        self.modulationAmplitudeSpinBox.setKeyboardTracking(False)
        self.modulationAmplitudeSpinBox.valueChanged.connect(
            self.change_modulation_amplitude
        )
        self.sineSourceFrequencySpinBox.setKeyboardTracking(False)
        self.sineSourceFrequencySpinBox.valueChanged.connect(
            self.change_sine_source_frequency
        )
        self.sineSourceAmplitudeSpinBox.setKeyboardTracking(False)
        self.sineSourceAmplitudeSpinBox.valueChanged.connect(
            self.change_sine_source_amplitude
        )
        self.sineSourceAmFrequencySpinBox.setKeyboardTracking(False)
        self.sineSourceAmFrequencySpinBox.valueChanged.connect(
            self.change_sine_source_am_frequency
        )
        self.sineSourceAmAmplitudeSpinBox.setKeyboardTracking(False)
        self.sineSourceAmAmplitudeSpinBox.valueChanged.connect(
            self.change_sine_source_am_amplitude
        )
        self.sweepSpeedComboBox.currentIndexChanged.connect(self.change_sweep_speed)

        self.spectroscopyTabs.setCurrentIndex(0)

    def on_connection_established(self):
        self.parameters = self.app.parameters
        self.control = self.app.control

        param2ui(
            self.parameters.modulation_frequency,
            self.modulationFrequencySpinBox,
            lambda value: value / MHz,
        )
        param2ui(
            self.parameters.modulation_amplitude,
            self.modulationAmplitudeSpinBox,
            lambda value: value / Vpp,
        )
        param2ui(self.parameters.sweep_speed, self.sweepSpeedComboBox)
        param2ui(
            self.parameters.sine_source_frequency,
            self.sineSourceFrequencySpinBox,
            lambda value: value / MHz,
        )
        param2ui(
            self.parameters.sine_source_amplitude,
            self.sineSourceAmplitudeSpinBox,
            lambda value: value / Vpp,
        )
        param2ui(
            self.parameters.sine_source_am_frequency,
            self.sineSourceAmFrequencySpinBox,
            lambda value: value / MHz * 1e6,
        )
        param2ui(
            self.parameters.sine_source_am_amplitude,
            self.sineSourceAmAmplitudeSpinBox,
            lambda value: value / Vpp,
        )

        self.parameters.dual_channel.add_callback(self.dual_channel_changed)

        def pid_only_mode_changed(pid_only_mode_enabled):
            """Disables controls that are irrelevant if PID-only mode is enabled"""
            widgets_to_disable = (
                self.modulation_frequency_group,
                self.modulation_amplitude_group,
                self.spectroscopyTabs,
            )
            for widget in widgets_to_disable:
                widget.setEnabled(not pid_only_mode_enabled)

        self.parameters.pid_only_mode.add_callback(pid_only_mode_changed)

        def pid_only_mode_changed(pid_only_mode_enabled):
            """Disables controls that are irrelevant if PID-only mode is enabled"""
            widgets_to_disable = (
                self.modulation_frequency_group,
                self.modulation_amplitude_group,
                self.spectroscopyTabs,
            )
            for widget in widgets_to_disable:
                widget.setEnabled(not pid_only_mode_enabled)

        self.parameters.pid_only_mode.add_callback(pid_only_mode_changed)

    def change_modulation_frequency(self):
        self.parameters.modulation_frequency.value = (
            self.modulationFrequencySpinBox.value() * MHz
        )
        self.control.write_registers()

    def change_modulation_amplitude(self):
        self.parameters.modulation_amplitude.value = (
            self.modulationAmplitudeSpinBox.value() * Vpp
        )
        self.control.write_registers()

    def change_sine_source_frequency(self):
        self.parameters.sine_source_frequency.value = (
            self.sineSourceFrequencySpinBox.value() * MHz
        )
        self.control.write_registers()

    def change_sine_source_amplitude(self):
        self.parameters.sine_source_amplitude.value = (
            self.sineSourceAmplitudeSpinBox.value() * Vpp
        )
        self.control.write_registers()

    def change_sine_source_am_frequency(self):
        self.parameters.sine_source_am_frequency.value = (
            self.sineSourceAmFrequencySpinBox.value() / 1e6 * MHz
        )
        self.control.write_registers()

    def change_sine_source_am_amplitude(self):
        self.parameters.sine_source_am_amplitude.value = (
            self.sineSourceAmAmplitudeSpinBox.value() * Vpp
        )
        self.control.write_registers()

    def change_sweep_speed(self, decimation):
        self.parameters.sweep_speed.value = decimation
        self.control.write_registers()

    def dual_channel_changed(self, value):
        self.spectroscopyBPanel.setEnabled(value)
        self.spectroscopyBPanelDisabled.setVisible(not value)
