# 文件: linien-server/linien_server/tracking/tpfc_tracker.py

import logging
import threading
import time
import numpy as np


# 公共的工具函数用于定点数转换
from .fixed_point_utils import FixedPointConverter
# 导入您的卡尔曼滤波器类
from ..kalman_filter import KalmanFilterTimeFrequency

logger = logging.getLogger(__name__)


class TPFCTrackerService(threading.Thread):
    """
    独立的 TPFC 跟踪服务，周期性执行卡尔曼滤波并更新 PID 目标。
    """
    def __init__(self, device,kalman_params,loop_interval_s=0.1):
        # loop_interval_s 决定了 Kalman Filter 的更新频率（例如 10 Hz）
        super().__init__()
        self.device = device
        self.loop_interval = loop_interval_s
        self.params = kalman_params

        self._stop_event = threading.Event()

        # --- I. CSR 输入 (读取误差信号和功率) ---
        # 确保 FPGA 模块名称 'error_calc' 与您在 linien_module.py 中的命名一致
        self.csr_error_signal = device.csr.error_calc.error_signal
        self.csr_power_signal = device.csr.error_calc.power_signal

        # --- II. CSR 输出 (写入 PID/相位目标的寄存器) ---
        # 【重要】这些寄存器（例如 kalman_targets.x_target_cmd）必须先在 FPGA 端定义 (CSRStorage)
        self.csr_x_target_cmd = device.csr.kalman_targets.x_target_cmd
        self.csr_f_target_cmd = device.csr.kalman_targets.f_target_cmd
        self.csr_t_target_cmd = device.csr.kalman_targets.t_target_cmd
        self.csr_power_threshold_cmd = device.csr.kalman_targets.power_threshold_target_cmd

        self.registers = device

        # --- III. 卡尔曼滤波器实例化 ---
        self.kf = KalmanFilterTimeFrequency(
            **self.params             # 使用参数传递来配置
            # dt=self.loop_interval,  # 跟踪服务的循环间隔 (dt)
            # process_noise_std_t=1e-18,  # 时间状态的过程噪声标准差 (s)
            # process_noise_std_f=1e-12,  # 频率状态的过程噪声标准差 (Hz)
            # process_noise_std_drift=1e-6,  # 漂移率状态的过程噪声标准差 (Hz/s)
            # base_measurement_noise_std=30e-15,  # 高功率时的基准测量噪声 (s)
            # fade_measurement_noise_std=5e-12,  # 衰落时的测量噪声 (s)
            # power_threshold=0.5,  # 功率衰落阈值 (相对值)
        )

        # --- IV. 定点数转换参数 (需与 FPGA 位宽一致) ---
        self.FP_WIDTH = 25
        self.FP_FRAC_BITS = 10
        # 实际校准因子应通过实验确定
        self.scale_factor_E = 1.0  # 误差信号定点数到时间(s)的转换因子
        self.scale_factor_P = 1.0  # 功率定点数到功率(W)的转换因子

    def stop(self):
        self._stop_event.set()

    def read_scan_tracking_status(self) -> dict[str, int]:
        """Return PL scan-tracking status (FSM + time-command output).

        The values originate from the ``ScanTrackingController`` CSRs exposed as
        ``scan_tracker_fsm_state`` and ``scan_tracker_time_command_out`` in the
        CSR map. This allows PS-side services or diagnostics to observe PL scan
        behavior without touching the gateware directly.
        """

        return self.registers.read_scan_tracker_status()


    def run(self):
        logger.info(f"TPFC 跟踪服务启动，更新频率: {1 / self.loop_interval} Hz")
        while not self._stop_event.is_set():
            start_time = time.time()
            try:
                self.process_tracking_step()
            except Exception as e:
                logger.error(f"TPFC 跟踪循环中发生错误: {e}")

            # 控制循环速率
            elapsed_time = time.time() - start_time
            sleep_time = self.loop_interval - elapsed_time
            if sleep_time > 0:
                time.sleep(sleep_time)

    def process_tracking_step(self):
        """执行一次完整的读-滤波-写循环"""
        # 1. 读取 FPGA 输入
        # raw_e = self.csr_error_signal.read()
        # raw_p = self.csr_power_signal.read()
        raw_e = self.registers.read_error_signal()
        raw_p = self.registers.read_power_signal()

        # 2. 转换定点数到物理量
        z_measurement = FixedPointConverter.fixed_to_float(
            raw_e,self.FP_WIDTH,self.FP_FRAC_BITS
        )*self.scale_factor_E
        P_received_power = FixedPointConverter.fixed_to_float(
            raw_p,self.FP_WIDTH,self.FP_FRAC_BITS
        )*self.scale_factor_P

        # 3. 卡尔曼滤波运算
        self.kf.predict()
        self.kf.update(z_measurement, P_received_power)

        # 4. 提取 PID 所需的最优估计值
        estimated_X_offset = self.kf.x[0, 0]  # 最优时间偏移估计 (s)
        estimated_F_offset = self.kf.x[1, 0]  # 最优频率偏移估计 (Hz)

        time_variance = self.kf.P[0, 0]       # 提取时间偏移的【方差】(Variance)
        if time_variance < 0:
            time_variance = 0
        time_uncertainty = np.sqrt(time_variance)  # 单位：秒
        power_threshold = self.kf.power_threshold


        # 5. 转换为 FPGA 定点数 (写入目标值)
        # 确保输出的定点数能被 PID 正确解析
        raw_x_target = FixedPointConverter.float_to_fixed(
            estimated_X_offset, self.FP_WIDTH, self.FP_FRAC_BITS
        )
        raw_f_target = FixedPointConverter.float_to_fixed(
            estimated_F_offset, self.FP_WIDTH, self.FP_FRAC_BITS
        )
        raw_time_uncertain_target = FixedPointConverter.float_to_fixed(
            time_uncertainty, self.FP_WIDTH, self.FP_FRAC_BITS
        )
        raw_power_threshold_target = FixedPointConverter.float_to_fixed(
            power_threshold, self.FP_WIDTH, self.FP_FRAC_BITS
        )
        # 6. 写入 CSR Storage，更新 PID 的目标设定值
        self.registers.write_kalman_targets(
            raw_x_target,
            raw_f_target,
            raw_time_uncertain_target,
            raw_power_threshold_target,
        )