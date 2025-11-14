from migen import Module, Signal, Cat, If
from misoc.interconnect.csr import AutoCSR, CSRStorage

class KalmanTargets(Module, AutoCSR):
    """
    用于接收 Kalman Filter 最优状态估计（PID 目标设定点）的寄存器组。
    格式为定点数 Q15.10（总位宽 25 位）。
    """
    def __init__(self, width=25):
        # 目标 1: 最优时间偏移估计 X(t)
        self.x_target_cmd = CSRStorage(width, name="x_target_cmd", description="Kalman: 最优时间偏移目标 (X)")
        # 目标 2: 最优频率偏移估计 Delta f
        self.f_target_cmd = CSRStorage(width, name="f_target_cmd", description="Kalman: 最优频率偏移目标 (Delta f)")
        # 目标 3: 对估计的不确定度
        self.t_target_cmd = CSRStorage(width, name="t_target_cmd", description="Kalman: 不确定度")
        # 目标 4： 功率阈值
        self.power_threshold_target_cmd = CSRStorage(width,name="power_threshold_target_cmd",description="功率阈值")