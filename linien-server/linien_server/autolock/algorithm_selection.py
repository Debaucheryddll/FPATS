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

import logging

from linien_common.common import N_POINTS, AutolockMode, determine_shift_by_correlation

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)


class AutolockAlgorithmSelector:
    """This class helps deciding which autolock method should be used."""
    # 该方法的作用是根据信号的抖动程度来选择应该使用哪种自动锁定策略，simple或者鲁棒模式
    def __init__(
        self,
        mode_preference,
        spectrum,
        additional_spectra,
        line_width,
        N_spectra_required=3,
    ):
        self.done = False
        self.mode = None
        self.spectra = [spectrum] + (additional_spectra or [])   # 这个光谱应该就对应gui中选择的那一段光谱
        self.N_spectra_required = N_spectra_required
        self.line_width = line_width

        if mode_preference != AutolockMode.AUTO_DETECT:
            self.mode = mode_preference
            self.done = True
            return

        self.check()

    def handle_new_spectrum(self, spectrum):
        self.spectra.append(spectrum)   # 每当有新的光谱传进来，就将新光谱存进spectra，然后用check函数去分析
        self.check()

    def check(self):
        if self.done:
            return True

        if len(self.spectra) < self.N_spectra_required:
            # 会首先检查目前照片够不够用
            # 最少三张，这就是为什么仅仅选取一个误差信号波形时无法启动自动锁定的原因
            return
        else:
            ref = self.spectra[0]    # 将第一个光谱作为参考基准来进行后续判断
            additional = self.spectra[1:] # 存储了第二个及之后的所有光谱图片
            abs_shifts = [
                abs(determine_shift_by_correlation(1, ref, spectrum)[0] * N_POINTS)
                for spectrum in additional
            ]
            max_shift = max(abs_shifts)
            # 负责日志记录一条信息，看看最大抖动幅度与信号线宽之间的比值，即判断信号的稳定程度，从而有助于设计者判断选择那种锁定模式
            logger.debug(
                f"jitter / line width ratio: {max_shift / (self.line_width / 2)}"
            )

            if max_shift <= self.line_width / 2:
                self.mode = AutolockMode.SIMPLE
            else:
                self.mode = AutolockMode.ROBUST

            self.done = True
