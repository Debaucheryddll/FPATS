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

from migen.build.generic_platform import (
    ConstraintError,
    Drive,
    IOStandard,
    Misc,
    Pins,
    Subsignal,
)
from migen.build.xilinx import XilinxPlatform

# https://github.com/RedPitaya/RedPitaya/blob/master/FPGA/release1/fpga/code/red_pitaya.xdc
# 定义了一个名为_io的列表用于存储接口信息
_io = [
    ("user_led", i, Pins(p), IOStandard("LVCMOS33"), Drive(4), Misc("SLEW SLOW"))
    for i, p in enumerate("F16 F17 G15 H15 K14 G14 J15 J14".split())
]
# +=表示是追加操作，将下边的元素添加到此前的列表后边
_io += [
    (
        "clk125",
        # 外部125MHz的时钟源引脚
        0,
        Subsignal("p", Pins("U18")),
        Subsignal("n", Pins("U19")),
        IOStandard("DIFF_HSTL_I_18"),
    ),
    (
        # 从data定义中我们可以看出明明adc芯片只有14位分辨率，但是它却对应了16个引脚
        # 现做解释：这16个引脚中，14个用于传输ADC的转换数据，另外2个很可能是用于传输状态或同步信号的专用引脚
        "adc",
        0,
        Subsignal("clk", Pins("N20 P20"), Misc("SLEW FAST"), Misc("DRIVE 8")),
        # 定义一个名为clk的信号，它连接到FPGA的N20和P20这两个物理引脚上
        # 请Vivado工具将这两个引脚的电气属性配置为：（局部约束）
        # 转换速率最快（SLEW FAST）并且输出驱动电流为8mA（DRIVE 8）。
        Subsignal("cdcs", Pins("V18"), Misc("SLEW FAST"), Misc("DRIVE 8")),
        Subsignal(
            "data_a",
            Pins("V17 U17 Y17 W16 Y16 W15 W14 Y14 " "W13 V12 V13 T14 T15 V15 T16 V16"),
        ),  # Misc("IOB TRUE")),
        Subsignal(
            "data_b",
            Pins("T17 R16 R18 P16 P18 N17 R19 T20 " "T19 U20 V20 W20 W19 Y19 W18 Y18"),
        ),  # Misc("IOB TRUE")),
        IOStandard("LVCMOS18"),  # , Drive(4)
    ),
    (
        "dac",
        0,
        Subsignal(
            "data",
            Pins("M19 M20 L19 L20 K19 J19 J20 H20 " "G19 G20 F19 F20 D20 D19"),
            Misc("SLEW SLOW"),
            Drive(4),
        ),
        # Misc("IOB TRUE")
        Subsignal("wrt", Pins("M17"), Drive(8), Misc("SLEW FAST")),
        Subsignal("sel", Pins("N16"), Drive(8), Misc("SLEW FAST")),
        Subsignal("rst", Pins("N15"), Drive(8), Misc("SLEW FAST")),
        Subsignal("clk", Pins("M18"), Drive(8), Misc("SLEW FAST")),
        IOStandard("LVCMOS33"),
    ),
    (
        "pwm",
        0,
        Pins("T10"),
        IOStandard("LVCMOS18"),
        Misc("DRIVE=12"),
        Misc("SLEW FAST"),
    ),
    (
        "pwm",
        1,
        Pins("T11"),
        IOStandard("LVCMOS18"),
        Misc("DRIVE=12"),
        Misc("SLEW FAST"),
    ),
    (
        "pwm",
        2,
        Pins("P15"),
        IOStandard("LVCMOS18"),
        Misc("DRIVE=12"),
        Misc("SLEW FAST"),
    ),
    (
        "pwm",
        3,
        Pins("U13"),
        IOStandard("LVCMOS18"),
        Misc("DRIVE=12"),
        Misc("SLEW FAST"),
    ),  # all IOB
    (
        "xadc",
        0,
        Subsignal("p", Pins("C20 E17 B19 E18 K9")),
        Subsignal("n", Pins("B20 D18 A20 E19 L10")),
        IOStandard("LVCMOS33"),
    ),
    (
        "exp",
        0,
        Subsignal("p", Pins("G17 H16 J18 K17 L14 L16 K16 M14")),
        Subsignal("n", Pins("G18 H17 H18 K18 L15 L17 J16 M15")),
        IOStandard("LVCMOS33"),
    ),
    (
        "sata",
        0,
        Subsignal("rx_p", Pins("T12")),
        Subsignal("rx_n", Pins("U12")),
        Subsignal("tx_p", Pins("U14")),
        Subsignal("tx_n", Pins("U15")),
        # IOStandard("DIFF_SSTL18_I")
    ),
    (
        "sata",
        1,
        Subsignal("rx_p", Pins("P14")),
        Subsignal("rx_n", Pins("R14")),
        Subsignal("tx_p", Pins("N18")),
        Subsignal("tx_n", Pins("P19")),
        # IOStandard("DIFF_SSTL18_I")
    ),
    (
        "cpu",
        0,
        # 这里的 "cpu" 模块并不是指在FPGA逻辑（PL - Programmable Logic）中用代码实现的一个软核CPU。
        # 它指的是Zynq芯片内部物理存在的、硬化的双核ARM Cortex-A9处理器
        # 这部分被称为处理器系统（PS - Processing System）。
        # 引脚定义都是 Pins("_ " * 54) 这样的形式
        # 这个 "_" 是一个占位符，它告诉Migen/LiteX构建系统：“这些引脚的具体位置我不管
        # 它们由Xilinx的Zynq配置工具（Vivado IP Integrator）自动处理，只需要知道有这些信号存在即可
        Subsignal("mio", Pins("_ " * 54)),      # ARM处理器专属的GPIO引脚，
        # 在Zynq的配置工具中，您可以将这些引脚配置成各种标准外设接口：
        # UART (串口，用于Linux控制台)I2C, SPI (用于连接其他芯片)Ethernet (网口)USBSD Card (SD卡接口)
        Subsignal("ps_clk", Pins("_ " * 1)),    # PS系统主时钟
        Subsignal("ps_porb", Pins("_ " * 1)),   # PS的上电复位信号（B代表低电平有效）。
        Subsignal("ps_srstb", Pins("_ " * 1)),  # PS的系统复位信号（低电平有效）

        # DDR 内存物理接口
        Subsignal("ddr_vrn", Pins("_ " * 1)),
        Subsignal("ddr_vrp", Pins("_ " * 1)),
        Subsignal("DDR_addr", Pins("_ " * 15)),     # (Address Bus)- 地址总线,15位，表明内存行和列地址
        Subsignal("DDR_ba", Pins("_ " * 3)),        # (Bank Address - 存储体地址总线)，3位，用于在DDR芯片内部选择不同的存储区块
        # 一个DDR内存芯片内部并不是一整块连续的存储空间，而是被分成了几个可以独立工作的子单元，每一个子单元就叫做一个 Bank (存储体)
        Subsignal("DDR_cas_n", Pins("_ " * 1)),     # 控制信号，列地址选通
        Subsignal("DDR_ck_n", Pins("_ " * 1)),      # DDR内存芯片的主时钟差分信号
        Subsignal("DDR_ck_p", Pins("_ " * 1)),      # DDR内存芯片的主时钟差分信号
        Subsignal("DDR_cke", Pins("_ " * 1)),
        Subsignal("DDR_cs_n", Pins("_ " * 1)),
        Subsignal("DDR_dm", Pins("_ " * 4)),
        Subsignal("DDR_dq", Pins("_ " * 32)),       # (Data Bus - 数据总线),32位，用于读取和写入数据的双向总线
        Subsignal("DDR_dqs_n", Pins("_ " * 4)),     # (Data Strobe - 数据选通信号)，差分信号对，是与数据同步的高速时钟信号，用于精确锁存数据。
        Subsignal("DDR_dqs_p", Pins("_ " * 4)),     # (Data Strobe - 数据选通信号)，差分信号对，是与数据同步的高速时钟信号，用于精确锁存数据。
        Subsignal("DDR_odt", Pins("_ " * 1)),
        Subsignal("DDR_ras_n", Pins("_ " * 1)),     # 控制信号，行地址选通
        Subsignal("DDR_reset_n", Pins("_ " * 1)),
        Subsignal("DDR_we_n", Pins("_ " * 1)),      # # 控制信号，写使能
    ),
]


class Platform(XilinxPlatform):
    default_clk_name = "clk125"
    default_clk_period = 8.0

    def __init__(self):     # 设定工程项目的基本信息，所用的芯片型号，接口列表以及编译工具
        XilinxPlatform.__init__(self, "xc7z010-clg400-1", _io, toolchain="vivado")
        self.toolchain.pre_synthesis_commands.append(
            "read_xdc -ref processing_system7_v5_4_processing_system7 ../verilog/system_processing_system7_0_0.xdc"  # noqa: E501
        )                                       # 导入关键约束文件
        self.toolchain.with_phys_opt = True     # 开启高级物理优化
        # phys_opt 指的是物理优化（Physical Optimization）。这是Vivado在布局布线后可以执行的一个额外优化步骤。
        # 它会尝试通过微调逻辑单元的物理位置和局部布线，来进一步改善设计的时序性能。

    def do_finalize(self, fragment):
        try:
            clk125 = self.lookup_request("clk125")
            self.add_period_constraint(clk125.p, 8)
            # 明确地告诉Vivado工具：“名为 clk125 的这个时钟信号，其周期（period）是8纳秒（ns）”
            self.add_platform_command(
                "set_clock_groups -asynchronous "
                # 在Zynq SoC中，通常有两个主要的、来源不同的时钟：一个是来自外部晶振、供给FPGA逻辑（PL）的 clk125；
                # 另一个是由ARM处理器系统（PS）内部生成、供给PL的 clk_fpga_0。
                # 这条命令告诉Vivado：“这两个时钟是异步的，它们之间没有任何确定的相位关系。”
                "-group [get_clocks -include_generated_clocks {clk}] "
                "-group [get_clocks -include_generated_clocks clk_fpga_0]",
                clk=clk125.p,
            )
            for i in range(2):
                try:
                    _ = self.lookup_request("adc", i)
                    # 这个函数会在你的设计中查找某个接口。如果你的具体设计恰好没有用到这个接口（比如某个简单的设计没有用到sata）
                    # 这个函数就会抛出ConstraintError异常。使用 try...except 可以让平台文件更加通用和健壮。
                    # 即使你的设计没有用到某个接口，这段约束代码也不会因为找不到接口而报错崩溃，而是会静默地跳过（pass)
                    # self.add_platform_command("set_input_delay "
                    #    "-clock {clk} 3.4 [get_ports {data}]",
                    #    clk=clk125, data=adc[0])
                except ConstraintError:
                    pass
        except ConstraintError:
            pass

        try:
            self.add_period_constraint(self.lookup_request("sata", 1).tx_p, 4)
        except ConstraintError:
            pass
        # 以下代码目的是阻止Migen为Zynq的PS（处理器系统）接口（如DDR、MIO）生成顶层的Verilog端口声明
        # Migen通常会把自己管理的所有带引脚的接口，都在最终生成的Verilog文件的模块端口列表里声明出来
        # 但对于Zynq的PS部分，它的DDR、MIO等引脚是硬核IP的特殊引脚
        # 它们的连接是由Vivado通过底层机制自动处理的，不应该出现在FPGA逻辑的顶层端口列表里
        # 这段代码通过遍历所有约束，找到名为"cpu"的接口，然后清空其所有引脚的identifiers（标识符）
        # Migen在生成Verilog时，如果发现一个引脚没有标识符，就不会为它创建端口声明
        for r, obj in self.constraint_manager.matched:
            if r[0] == "cpu":
                for s in r[2:]:
                    for c in s.constraints:
                        if isinstance(c, Pins):
                            c.identifiers = []
