# 文件: linien-server/linien_server/tracking/tpfc_tracker.py

import logging
import threading
import time
import numpy as np


# 公共的工具函数用于定点数转换
from linien_server.tracking.fixed_point_utils import FixedPointConverter
# 导入您的卡尔曼滤波器类
from linien_server.kalman_filter import KalmanFilterTimeFrequency

logger = logging.getLogger(__name__)


class TPFCTrackerService(threading.Thread):
    """
    独立的 TPFC 跟踪服务，周期性执行卡尔曼滤波并更新 PID 目标。
    """
    def __init__(self, device, kalman_params, loop_interval_s=0.1):
        # loop_interval_s 决定了 Kalman Filter 的更新频率（例如 10 Hz）
        super().__init__()
        self.device = device
        self.loop_interval = loop_interval_s
        self.params = dict(kalman_params)
        self.params.setdefault("dt", self.loop_interval)

        self._stop_event = threading.Event()
        # 关于寄存器读写操作在registers中进行定义，在卡尔曼线程中只需要调用即可
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

    def _read_measurements(self):
        """从 CSR 读取并转换误差/功率测量值，返回浮点物理量。"""

        raw_e = self.registers.read_error_signal()
        raw_p = self.registers.read_power_signal()

        z_measurement = FixedPointConverter.fixed_to_float(
            raw_e, self.FP_WIDTH, self.FP_FRAC_BITS
        ) * self.scale_factor_E
        P_received_power = FixedPointConverter.fixed_to_float(
            raw_p, self.FP_WIDTH, self.FP_FRAC_BITS
        ) * self.scale_factor_P

        return z_measurement, P_received_power


    def process_tracking_step(self):
        """执行一次完整的读-滤波-写循环"""
        # 1. 读取 FPGA 输入
        # raw_e = self.csr_error_signal.read()
        try:
            z_measurement, P_received_power = self._read_measurements()
        except Exception:  # 读取或转换异常时跳过本周期
            logger.exception("读取误差/功率寄存器失败，跳过本周期。")
            return

        # 保护：如果测量或功率值为 NaN/Inf，则不更新滤波器，避免破坏状态矩阵
        if not np.isfinite(z_measurement) or not np.isfinite(P_received_power):
            logger.warning(
                "检测到非有限测量值(z=%s, P=%s)，跳过本周期。",
                z_measurement,
                P_received_power,
            )
            return

        # 3. 卡尔曼滤波运算
        self.kf.predict()
        self.kf.update(z_measurement, P_received_power)

        # 4. 提取 PID 所需的最优估计值
        estimated_X_offset = self.kf.x[0, 0]  # 最优时间偏移估计 (s)
        estimated_F_offset = self.kf.x[1, 0]  # 最优频率偏移估计 (Hz)

        time_variance = max(self.kf.P[0, 0], 0)  # 提取时间偏移的方差并裁剪负值
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