# 文件名: test_kalman_filter.py (最终修正版 - 统一真实模型 + 噪声调整)

import logging

import matplotlib
import numpy as np

matplotlib.use('TKAgg')
import matplotlib.pyplot as plt

from linien_server.kalman_filter import (KalmanFilterTimeFrequency)


# --- 校准函数 ---
C1 = 4.17e-13
C3 = 5.00e-13


def calibrate_error_signal_cubic(error_signal_E: float) -> float:
    E_clipped = np.clip(error_signal_E, -1.0, 1.0)
    return C1 * E_clipped + C3 * (E_clipped ** 3)


# --- 主测试函数 ---
def test_run_kalman_filter_3d_tuned_v2():  # pytest 会找到这个
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    logger = logging.getLogger(__name__)

    sim_dt = 0.001
    num_steps = 1000
    total_time = sim_dt * num_steps
    POWER_HIGH = 1.0
    POWER_LOW = 0.1
    POWER_THRESHOLD = 0.5
    fade_zones = [(300, 400), (700, 850)]  # 衰落区位置

    # --- 统一的真实状态演化 ---
    time_axis_sim = np.arange(num_steps) * sim_dt
    true_time = np.zeros(num_steps)
    true_freq = np.zeros(num_steps)
    true_drift = np.zeros(num_steps)

    # 真实世界的初始状态和物理过程
    true_initial_time_offset = -800e-15  # (s) 从 S 曲线的左侧开始

    # 大幅减小频率偏移和漂移率，使轨迹保持在 S 曲线的线性范围内
    true_initial_freq_offset = 1.5e-15  # (新的: 1.5 fs/s)
    true_freq_drift_rate = 0.5e-12  # (新的: 500 fs/s^2)

    true_time[0] = true_initial_time_offset
    true_freq[0] = true_initial_freq_offset
    true_drift[0] = true_freq_drift_rate

    # 根据三阶模型(恒定加速度)生成 *唯一* 的真实轨迹
    for k in range(1, num_steps):
        true_drift[k] = true_freq_drift_rate  # 真实漂移率是恒定的
        true_freq[k] = true_freq[k - 1] + true_drift[k - 1] * sim_dt
        true_time[k] = true_time[k - 1] + true_freq[k - 1] * sim_dt + 0.5 * true_drift[k - 1] * sim_dt ** 2

    true_time_fs = true_time * 1e15  # 转换为 fs 用于绘图和插值

    # --- 生成 E_ref (用于生成测量值) ---
    # S 曲线的形状
    A = 0.05
    sigma = 210
    c1 = 250
    c2 = -250
    _t_axis_orig = np.linspace(-1500, 1500, 1000)
    _V1_float_orig = A * np.exp(-(_t_axis_orig - c1) ** 2 / (2 * sigma ** 2))
    _V2_float_orig = A * np.exp(-(_t_axis_orig - c2) ** 2 / (2 * sigma ** 2))
    _E_ref_sum = np.abs(_V1_float_orig) + np.abs(_V2_float_orig)
    _E_ref_diff = np.abs(_V1_float_orig) - np.abs(_V2_float_orig)
    E_ref_orig = np.divide(_E_ref_diff, _E_ref_sum, out=np.zeros_like(_E_ref_diff), where=_E_ref_sum != 0)

    # 将真实的时间轨迹 (true_time_fs) 映射到 S 曲线上，得到无噪声的 E 信号
    E_ref = np.interp(true_time_fs, _t_axis_orig, E_ref_orig, left=E_ref_orig[0], right=E_ref_orig[-1])

    # --- (关键) 调优三阶噪声参数 ---
    kf_dt = sim_dt
    # 过程噪声：我们相信模型(恒定漂移率)是基本准确的，但允许有少量噪声
    proc_noise_t_std = 1e-18  # (s) (1 as/s)
    proc_noise_f_std = 1e-15  # (Hz) (1 fs/s)

    # --- (推荐调优) ---
    proc_noise_std_drift = 1e-12  # (新的: 1000 fs/s^2)
    # --- (调优结束) ---

    # --- (关键修改：根据用户要求调整噪声) ---
    # 测量噪声：
    # base_meas_noise_t_std = 800e-15  # (旧的: 800 fs 正常噪声)
    # fade_meas_noise_t_std = 5000e-15 # (旧的: 5 ps 衰落噪声)

    base_meas_noise_t_std = 200e-15  # (新的: 200 fs 正常噪声 - 噪声更小)
    fade_meas_noise_t_std = 10000e-15  # (新的: 10 ps 衰落噪声 - 噪声更大)
    # --- (修改结束) ---

    # --- (修改) 初始化三阶滤波器 ---
    kf = KalmanFilterTimeFrequency(
        dt=kf_dt,
        process_noise_std_t=proc_noise_t_std,
        process_noise_std_f=proc_noise_f_std,
        process_noise_std_drift=proc_noise_std_drift,
        base_measurement_noise_std=base_meas_noise_t_std,  # <--- 使用新的 200fs
        fade_measurement_noise_std=fade_meas_noise_t_std,  # <--- 使用新的 10ps
        power_threshold=POWER_THRESHOLD,
        #  初始状态为 3x1，但初始漂移率设为 0，让滤波器自己去学
        initial_state=np.array([[true_initial_time_offset], [true_initial_freq_offset], [0.0]]),
        #  初始协方差 (给漂移率一个很大的初始不确定性)
        # 告诉滤波器：我对时间/频率的初始猜测比较准，但我对漂移率的猜测(0.0)完全不确定
        # (注意: 这里的 base_meas_noise_t_std**2 会自动使用新的 200fs^2)
        initial_covariance_diag=(base_meas_noise_t_std ** 2, (1e-14) ** 2, (1e-11) ** 2)  # (新的)
    )

    # --- 模拟数据存储 ---
    measurements_calibrated = np.zeros(num_steps)
    power_levels = np.zeros(num_steps)
    estimated_time = np.zeros(num_steps)
    estimated_freq = np.zeros(num_steps)
    estimated_drift = np.zeros(num_steps)
    time_uncertainty_std = np.zeros(num_steps)
    freq_uncertainty_std = np.zeros(num_steps)
    drift_uncertainty_std = np.zeros(num_steps)

    logger.info("开始运行调优后的三阶卡尔曼滤波仿真 (增强噪声对比)...")
    for k in range(num_steps):
        in_fade = any(start <= k < end for (start, end) in fade_zones)
        current_power = POWER_LOW if in_fade else POWER_HIGH

        # --- (根据用户要求调整噪声) ---
        # 模拟器现在将使用新的噪声标准差
        current_meas_noise_t_std = fade_meas_noise_t_std if in_fade else base_meas_noise_t_std
        # --- (修改结束) ---

        power_levels[k] = current_power

        # E_ref[k] 是真实的 E (现在不再饱和)
        delta_t_calibrated_true = calibrate_error_signal_cubic(E_ref[k])
        # 论文模型是在 δt 上加噪声
        measurements_calibrated[k] = delta_t_calibrated_true + np.random.normal(0, current_meas_noise_t_std)

        if k == 0:
            kf.update(measurements_calibrated[k], current_power)
        else:
            kf.predict()
            kf.update(measurements_calibrated[k], current_power)

        est_t, est_f, est_d = kf.get_state()
        estimated_time[k] = est_t
        estimated_freq[k] = est_f
        estimated_drift[k] = est_d
        cov = kf.get_state_covariance()
        time_uncertainty_std[k] = np.sqrt(max(0, cov[0, 0]))
        freq_uncertainty_std[k] = np.sqrt(max(0, cov[1, 1]))
        drift_uncertainty_std[k] = np.sqrt(max(0, cov[2, 2]))
    logger.info("仿真结束。")

    # ====== 4. 打印关键点对比表 ======
    print(
        "\nSim Time(s)| Power | True T (fs) | Cal.Meas (fs)| Est T (fs)  | True F (fs/s)| Est F (fs/s)| True D(fs/s^2)| Est D(fs/s^2)")
    print(
        "-------------------------------------------------------------------------------------------------------------------------------")
    sample_sim_times = np.array([0.1, 0.299, 0.300, 0.4, 0.699, 0.700, 0.849, 0.850, 0.95])
    for t_sample in sample_sim_times:
        idx = (np.abs(time_axis_sim - t_sample)).argmin()
        if idx < len(estimated_time):
            p_val = power_levels[idx]
            t_true_fs = true_time_fs[idx]
            t_meas_fs = measurements_calibrated[idx] * 1e15
            t_est_fs = estimated_time[idx] * 1e15
            f_true_fss = true_freq[idx] * 1e15  # 转换为 fs/s
            f_est_fss = estimated_freq[idx] * 1e15  # 转换为 fs/s
            d_true_fss2 = true_drift[idx] * 1e15  # 转换为 fs/s^2
            d_est_fss2 = estimated_drift[idx] * 1e15  # 转换为 fs/s^2
            print(
                f"{t_sample:9.3f} | {p_val:5.1f} | {t_true_fs:11.3f} | {t_meas_fs:12.3f} | {t_est_fs:11.3f} | {f_true_fss:11.1f} | {f_est_fss:11.1f} | {d_true_fss2:11.1f} | {d_est_fss2:11.1f}")
    print(
        "===============================================================================================================================\n")

    # --- 5. 绘图比较 (5 个子图) ---
    try:
        fig, axs = plt.subplots(5, 1, figsize=(12, 15), sharex=False, gridspec_kw={'hspace': 0.6})  # 增加垂直间距

        # S-Curve (axs[0])
        axs[0].plot(_t_axis_orig, E_ref_orig, color='green', label='Theoretical S-Curve')
        axs[0].set_title('Input S-Curve Shape Definition')
        axs[0].set_xlabel('Relative Time Offset (fs)');
        axs[0].set_ylabel('Error (E)')
        axs[0].grid(True);
        axs[0].set_xlim(-1500, 1500);
        axs[0].legend()

        # 功率电平图 (axs[1])
        axs[1].plot(time_axis_sim, power_levels, color='orange', label='Simulated Power Level')
        axs[1].axhline(y=POWER_THRESHOLD, color='r', linestyle='--', label='Power Threshold')
        axs[1].set_title('Simulated Power Fades')
        axs[1].set_xlabel('Simulation Time (s)');
        axs[1].set_ylabel('Power (a.u.)')
        axs[1].grid(True);
        axs[1].set_ylim(-0.1, 1.1);
        axs[1].legend(loc='upper right')

        # 时间偏移图 (axs[2])
        axs[2].plot(time_axis_sim, true_time_fs, 'k--', label='True Time Offset', linewidth=2)
        axs[2].plot(time_axis_sim, measurements_calibrated * 1e15, '.', color='gold', markersize=3, alpha=0.4,
                    label='Noisy Measurements (Input)')
        axs[2].plot(time_axis_sim, estimated_time * 1e15, 'b-', linewidth=2, label='KF Smoothed Output')
        axs[2].fill_between(time_axis_sim, (estimated_time - 2 * time_uncertainty_std) * 1e15,
                            (estimated_time + 2 * time_uncertainty_std) * 1e15, color='blue', alpha=0.15,
                            label='±2σ Uncertainty')
        axs[2].set_title('Kalman Filter: Time Offset Tracking (3D State)')
        axs[2].set_ylabel('Time Offset (fs)');
        axs[2].set_xlabel('Simulation Time (s)')
        # (修改) 动态Y轴范围
        plot_min_t = min(np.nanmin(true_time_fs), np.nanmin(estimated_time * 1e15)) - 2000
        plot_max_t = max(np.nanmax(true_time_fs), np.nanmax(estimated_time * 1e15)) + 2000
        axs[2].set_ylim(plot_min_t, plot_max_t)  # 现在这个范围会很合理，比如 [-3000, 1000]
        axs[2].grid(True)
        axs[2].legend(loc='upper left')

        # 频率偏移图 (axs[3], 修改单位)
        axs[3].plot(time_axis_sim, true_freq * 1e15, 'k--', label='True Frequency Offset (fs/s)')  # 转换为 fs/s
        axs[3].plot(time_axis_sim, estimated_freq * 1e15, 'r-', linewidth=2,
                    label='Estimated Frequency Offset (fs/s)')  # 转换为 fs/s
        axs[3].fill_between(time_axis_sim, (estimated_freq - 2 * freq_uncertainty_std) * 1e15,
                            (estimated_freq + 2 * freq_uncertainty_std) * 1e15, color='red', alpha=0.15,
                            label='±2σ Uncertainty')
        axs[3].set_title('Kalman Filter: Frequency Offset Estimation (3D State)')
        axs[3].set_ylabel('Frequency Offset (fs/s)');
        axs[3].set_xlabel('Simulation Time (s)')  # 修改Y轴标签
        axs[3].grid(True)
        axs[3].legend(loc='upper left')
        # (修改) 动态Y轴范围
        plot_min_f = min(np.nanmin(true_freq * 1e15), np.nanmin(estimated_freq * 1e15)) - 500
        plot_max_f = max(np.nanmax(true_freq * 1e15), np.nanmax(estimated_freq * 1e15)) + 500
        axs[3].set_ylim(plot_min_f, plot_max_f)

        # 漂移率跟踪图 (axs[4])
        axs[4].plot(time_axis_sim, true_drift * 1e15, 'k--', label='True Frequency Drift (fs/s^2)')  # 转换为 fs/s^2
        axs[4].plot(time_axis_sim, estimated_drift * 1e15, 'g-', linewidth=2,
                    label='Estimated Frequency Drift (fs/s^2)')  # 转换为 fs/s^2
        axs[4].fill_between(time_axis_sim, (estimated_drift - 2 * drift_uncertainty_std) * 1e15,
                            (estimated_drift + 2 * drift_uncertainty_std) * 1e15, color='green', alpha=0.15,
                            label='±2σ Uncertainty')
        axs[4].set_title('Kalman Filter: Frequency Drift Estimation (3D State)')
        axs[4].set_ylabel('Freq. Drift (fs/s^2)');
        axs[4].set_xlabel('Simulation Time (s)')  # 修改Y轴标签
        axs[4].grid(True)
        axs[4].legend(loc='upper left')
        # 动态Y轴范围
        plot_min_d = min(np.nanmin(true_drift * 1e15), np.nanmin(estimated_drift * 1e15)) - 1000
        plot_max_d = max(np.nanmax(true_drift * 1e15), np.nanmax(estimated_drift * 1e15)) + 1000
        axs[4].set_ylim(plot_min_d, plot_max_d)

        # 添加衰落区
        for i in [1, 2, 3, 4]:  # 循环 4 个图
            for (start, end) in fade_zones:
                label = 'Signal Fade Zone' if start == fade_zones[0][0] and i == 1 else None
                axs[i].axvspan(start * sim_dt, end * sim_dt, color='red', alpha=0.1, label=label)

        # 更新图例
        axs[1].legend(loc='upper right')
        axs[2].legend(loc='upper left')
        axs[3].legend(loc='upper left')
        axs[4].legend(loc='upper left')

        plt.subplots_adjust(hspace=0.6)
        plt.show()

    except ImportError:
        logger.warning("Matplotlib 未安装，无法绘制结果图。")
    except Exception as e:
        logger.error(f"绘图时发生错误: {e}")


if __name__ == "__main__":
    test_run_kalman_filter_3d_tuned_v2()