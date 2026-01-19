# 文件名: linien_server/kalman_filter.py (最终版：三阶 + 动态R)

import logging

import numpy as np

logger = logging.getLogger(__name__)


class KalmanFilterTimeFrequency:
    """
    一个用于跟踪相对时间偏移、频率偏移和频率漂移率的线性卡尔曼滤波器 (三阶状态)。
    (修改版：使用动态R处理信号衰落)

    状态向量 x = [时间偏移 (s), 频率偏移 (Hz), 频率漂移率 (Hz/s)]^T
    测量值 z = [测量到的时间偏移 (s)]
    """

    def __init__(self, dt: float,
                 process_noise_std_t: float,
                 process_noise_std_f: float,
                 process_noise_std_drift: float,
                 base_measurement_noise_std: float,
                 fade_measurement_noise_std: float,  # <-- (新增) 衰落时的噪声
                 power_threshold: float,
                 initial_state: np.ndarray = np.zeros((3, 1)),
                 initial_covariance_diag: tuple[float, float, float] = (1e-9, 1e-3, 1e-1)):

        if dt <= 0:
            raise ValueError("dt 必须是正数")
        if base_measurement_noise_std <= 0:
            raise ValueError("base_measurement_noise_std 必须是正数")
        if fade_measurement_noise_std <= base_measurement_noise_std:
            logger.warning("衰落噪声应大于基础噪声")

        self.dt = dt
        self.power_threshold = power_threshold

        # --- 状态向量 (3x1) ---
        self.x = np.asarray(initial_state).reshape(3, 1)

        # --- 状态转移矩阵 F (3x3) ---
        self.F = np.array([[1.0, self.dt, 0.5 * self.dt ** 2],
                           [0.0, 1.0, self.dt],
                           [0.0, 0.0, 1.0]])

        # --- 测量矩阵 H (1x3) ---
        self.H = np.array([[1.0, 0.0, 0.0]])

        # --- 过程噪声协方差矩阵 Q (3x3) ---
        q_drift_var = process_noise_std_drift ** 2
        q_f_var = process_noise_std_f ** 2
        q_t_var = process_noise_std_t ** 2

        Q_drift = np.array([
            [q_drift_var * (dt ** 5) / 20.0, q_drift_var * (dt ** 4) / 8.0, q_drift_var * (dt ** 3) / 6.0],
            [q_drift_var * (dt ** 4) / 8.0, q_drift_var * (dt ** 3) / 3.0, q_drift_var * (dt ** 2) / 2.0],
            [q_drift_var * (dt ** 3) / 6.0, q_drift_var * (dt ** 2) / 2.0, q_drift_var * (dt ** 1) / 1.0]
        ])
        Q_freq = np.array([
            [q_f_var * (dt ** 3) / 3.0, q_f_var * (dt ** 2) / 2.0, 0],
            [q_f_var * (dt ** 2) / 2.0, q_f_var * (dt ** 1) / 1.0, 0],
            [0, 0, 0]
        ])
        Q_time = np.diag([q_t_var * dt, 0, 0])
        self.Q = Q_drift + Q_freq + Q_time

        # --- (修改) 存储两种测量噪声 ---
        self.R_base = np.array([[base_measurement_noise_std ** 2]])
        self.R_fade = np.array([[fade_measurement_noise_std ** 2]])  # <-- 衰落时的 R

        # --- 状态协方差矩阵 P (3x3) ---
        if len(initial_covariance_diag) != 3 or any(p < 0 for p in initial_covariance_diag):
            raise ValueError("initial_covariance_diag 必须包含三个非负数")
        self.P = np.diag(initial_covariance_diag)

        logger.info(f"三维卡尔曼滤波器(动态R)初始化完成: dt={self.dt} s, PowerThreshold={self.power_threshold}")

    def predict(self) -> np.ndarray:
        """
        卡尔曼滤波器预测步骤 (三维)。
        """
        previous_state = self.x.copy()
        previous_covariance = self.P.copy()
        self.P = self.F @ self.P @ self.F.T + self.Q
        self.x = self.F @ self.x
        logger.debug(
            "KF predict: x_prev=%s P_prev=%s x_pred=%s P_pred=%s",
            previous_state.flatten(),
            previous_covariance,
            self.x.flatten(),
            self.P,
        )
        return self.x

    def update(self, z: float, power_level: float) -> np.ndarray:
        """
        (修改) 卡尔曼滤波器更新步骤 (三维)。
        使用动态 R 来处理信号衰落，而不是跳过更新。
        """

        # --- (关键修改) 动态 R 逻辑 ---
        if power_level < self.power_threshold:
            # 功率低：使用极大的测量噪声 R_fade
            current_R = self.R_fade
            logger.debug(f"功率 {power_level} < {self.power_threshold}, 使用 R_fade。")
        else:
            # 功率高：使用基础测量噪声 R_base
            current_R = self.R_base
            logger.debug(f"功率 {power_level} >= {self.power_threshold}, 使用 R_base。")
        # ---------------------------

        # --- 标准三维更新 ---
        # S = H * P_k^- * H^T + current_R
        S = self.H @ self.P @ self.H.T + current_R
        try:
            # K = P_k^- * H^T * S^{-1} (K 是 3x1)
            K = self.P @ self.H.T @ np.linalg.inv(S)
        except np.linalg.LinAlgError:
            logger.warning("测量残差协方差 S 接近奇异，使用伪逆计算卡尔曼增益。")
            try:
                K = self.P @ self.H.T @ np.linalg.pinv(S)
            except np.linalg.LinAlgError:
                logger.error("计算卡尔曼增益时发生线性代数错误，跳过更新。")
                return self.x

        # y = z - H * x_k^- (y 是 1x1 标量)
        y = z - self.H @ self.x
        logger.debug(
            "KF update: z=%s power=%s residual=%s S=%s K=%s",
            z,
            power_level,
            y,
            S,
            K,
        )

        # x_k^+ = x_k^- + K * y
        # 当 R 很大 -> S 很大 -> K 很小 -> x 几乎不变 (等于预测值)
        # 当 R 很小 -> K 较大 -> x 被测量值修正
        self.x = self.x + K * y

        # P_k^+ = (I - K*H) * P_k^- * (I - K*H)^T + K * R * K^T
        I_KH = np.eye(self.P.shape[0]) - K @ self.H
        # 当 R 很大 -> K 很小 -> I_KH 接近 I -> P ≈ P_k^-
        # (这不完全对，P 应该 = P_k^-。Joseph Form 在这里是正确的。)
        self.P = (I_KH @ self.P @ I_KH.T) + (K @ current_R @ K.T)
        logger.debug(
            "KF update result: x_post=%s P_post=%s R_used=%s",
            self.x.flatten(),
            self.P,
            current_R,
        )
        return self.x

    def get_state(self) -> np.ndarray:
        return self.x.flatten()

    def get_time_offset(self) -> float:
        return float(self.x[0, 0])

    def get_frequency_offset(self) -> float:
        return float(self.x[1, 0])

    def get_frequency_drift(self) -> float:
        return float(self.x[2, 0])

    def get_state_covariance(self) -> np.ndarray:
        return self.P