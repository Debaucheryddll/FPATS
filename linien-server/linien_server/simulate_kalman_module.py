"""卡尔曼滤波器模块仿真。"""

from __future__ import annotations

import argparse
import statistics
import time
from dataclasses import dataclass
from pathlib import Path

import importlib.util
import matplotlib
import numpy as np

matplotlib.use("Agg")
import matplotlib.pyplot as plt

REPO_ROOT = Path(__file__).resolve().parents[1]


def _load_module(module_name: str, relative_path: str):
    module_path = REPO_ROOT / relative_path
    spec = importlib.util.spec_from_file_location(module_name, module_path)
    module = importlib.util.module_from_spec(spec)
    assert spec and spec.loader
    spec.loader.exec_module(module)
    return module


_kalman_mod = _load_module("sim_kalman_filter", "linien_server/kalman_filter.py")
KalmanFilterTimeFrequency = _kalman_mod.KalmanFilterTimeFrequency

FP_FRAC_BITS = 10
FP_SCALE = 1 << FP_FRAC_BITS


@dataclass
class StepResult:
    step: int
    time_offset_fs: float
    power: float
    v1_power: float
    v2_power: float
    error_float: float
    error_e: float
    measurement_z: float
    predicted_x: float
    state_x: float
    gain_k0: float
    used_r: float
    is_fade: bool


@dataclass
class TimingStats:
    calc_error_us: list[float]
    convert_us: list[float]
    predict_us: list[float]
    update_us: list[float]
    total_us: list[float]


def quantize_error_signal(value: float) -> int:
    clipped = float(np.clip(value, -1.0, 1.0))
    return int(np.clip(round(clipped * FP_SCALE), -FP_SCALE, FP_SCALE))


def dequantize_error_signal(raw: int) -> float:
    return raw / FP_SCALE


def calc_error_signal(v1: float, v2: float) -> float:
    num = abs(v1) - abs(v2)
    den = abs(v1) + abs(v2)
    if den == 0:
        return 0.0
    return num / den


def load_default_kalman_params() -> dict:
    return {
        "dt": 0.01,
        "process_noise_std_t": 1e-1,
        "process_noise_std_f": 1e-1,
        "process_noise_std_drift": 1e-2,
        "base_measurement_noise_std": 1e-2,
        "fade_measurement_noise_std": 1e-1,
        "power_threshold": 60,
        "initial_state": np.array([[0.0], [0.0], [0.0]]),
        "initial_covariance_diag": (10.0, 10.0, 10.0),
    }


def summarize_timing(name: str, values: list[float]) -> str:
    if not values:
        return f"{name}: n/a"
    return (
        f"{name}: mean={statistics.mean(values):.3f} us, "
        f"p95={np.percentile(values, 95):.3f} us, max={max(values):.3f} us"
    )


def build_power_profile(steps: int) -> tuple[np.ndarray, np.ndarray]:
    """构造“常规高功率 + 突发深衰落”功率曲线。

    - 正常区间：功率在 160~200 之间波动（高于阈值）
    - 衰落区间：功率在 5~20 之间（远低于阈值）
    """
    k = np.arange(steps)
    power = 180.0 + 20.0 * np.sin(2.0 * np.pi * k / 250.0)

    fade_mask = np.zeros(steps, dtype=bool)
    fade_windows = [
        (int(0.22 * steps), int(0.28 * steps)),
        (int(0.52 * steps), int(0.58 * steps)),
        (int(0.78 * steps), int(0.84 * steps)),
    ]
    for start, end in fade_windows:
        fade_mask[start:end] = True

    depth = 5.0 + 15.0 * (0.5 + 0.5 * np.sin(2.0 * np.pi * k / 60.0))
    power[fade_mask] = depth[fade_mask]
    return power, fade_mask


def run_simulation(steps: int, seed: int = 42) -> tuple[list[StepResult], TimingStats, dict]:
    rng = np.random.default_rng(seed)
    params = load_default_kalman_params()
    kf = KalmanFilterTimeFrequency(**params)

    timings = TimingStats([], [], [], [], [])
    results: list[StepResult] = []

    # 双高斯功率包络 -> 误差信号 E=(|V1|-|V2|)/(|V1|+|V2|)
    scan = np.linspace(-1500.0, 1500.0, steps)
    sigma = 280.0
    center_1 = 320.0
    center_2 = -320.0
    baseline = 0.003
    amplitude = 0.047

    power_profile, fade_mask = build_power_profile(steps)

    for k in range(steps):
        t_total0 = time.perf_counter_ns()

        power = float(power_profile[k])
        in_fade = bool(fade_mask[k])

        t_err0 = time.perf_counter_ns()
        tau = float(scan[k])
        p1 = float(baseline + amplitude * np.exp(-((tau - center_1) ** 2) / (2 * sigma**2)))
        p2 = float(baseline + amplitude * np.exp(-((tau - center_2) ** 2) / (2 * sigma**2)))
        e_float = calc_error_signal(p1, p2)
        t_err1 = time.perf_counter_ns()

        t_conv0 = time.perf_counter_ns()
        e_raw = quantize_error_signal(e_float)
        e_meas = dequantize_error_signal(e_raw)

        # 常规高功率：测量噪声小，输出应接近实际误差
        # 衰落低功率：测量噪声明显增大，滤波应更依赖预测值
        meas_noise_std = 0.01 if not in_fade else 0.18
        z = float(np.clip(e_meas + rng.normal(0.0, meas_noise_std), -1.0, 1.0))
        t_conv1 = time.perf_counter_ns()

        t_pred0 = time.perf_counter_ns()
        kf.predict()
        predicted_x = float(kf.x[0, 0])
        t_pred1 = time.perf_counter_ns()

        current_r = kf.R_fade if power < kf.power_threshold else kf.R_base
        S = kf.H @ kf.P @ kf.H.T + current_r
        K = kf.P @ kf.H.T @ np.linalg.inv(S)

        t_up0 = time.perf_counter_ns()
        kf.update(z, power)
        t_up1 = time.perf_counter_ns()

        timings.calc_error_us.append((t_err1 - t_err0) / 1000.0)
        timings.convert_us.append((t_conv1 - t_conv0) / 1000.0)
        timings.predict_us.append((t_pred1 - t_pred0) / 1000.0)
        timings.update_us.append((t_up1 - t_up0) / 1000.0)
        timings.total_us.append((time.perf_counter_ns() - t_total0) / 1000.0)

        results.append(
            StepResult(
                step=k,
                time_offset_fs=tau,
                power=power,
                v1_power=p1,
                v2_power=p2,
                error_float=e_float,
                error_e=e_meas,
                measurement_z=z,
                predicted_x=predicted_x,
                state_x=float(kf.x[0, 0]),
                gain_k0=float(K[0, 0]),
                used_r=float(current_r[0, 0]),
                is_fade=in_fade,
            )
        )

    return results, timings, params


def save_v1_v2_power_plot(results: list[StepResult], output_path: Path) -> Path:
    t_fs = np.array([r.time_offset_fs for r in results])
    v1 = np.array([r.v1_power for r in results])
    v2 = np.array([r.v2_power for r in results])

    fig, ax = plt.subplots(figsize=(10, 4.5))
    ax.plot(t_fs, v1, lw=1.8, label="|V1| power")
    ax.plot(t_fs, v2, lw=1.8, label="|V2| power")
    ax.set_xlabel("Time offset (fs)")
    ax.set_ylabel("Signal amplitude (a.u.)")
    ax.set_title("V1/V2 power vs time offset")
    ax.grid(True, alpha=0.3)
    ax.legend(loc="best")

    output_path.parent.mkdir(parents=True, exist_ok=True)
    fig.tight_layout()
    fig.savefig(output_path, dpi=160)
    plt.close(fig)
    return output_path


def save_comparison_plot(results: list[StepResult], output_path: Path, power_threshold: float) -> Path:
    t_step = np.array([r.step for r in results])
    t_fs = np.array([r.time_offset_fs for r in results])
    v1 = np.array([r.v1_power for r in results])
    v2 = np.array([r.v2_power for r in results])
    e_float = np.array([r.error_float for r in results])
    e_quantized = np.array([r.error_e for r in results])
    z = np.array([r.measurement_z for r in results])
    x_pred = np.array([r.predicted_x for r in results])
    x_post = np.array([r.state_x for r in results])
    p = np.array([r.power for r in results])
    fade = np.array([r.is_fade for r in results], dtype=bool)

    fig, axes = plt.subplots(3, 1, figsize=(12, 10))
    axes[0].plot(t_fs, v1, lw=1.5, label="|V1| power")
    axes[0].plot(t_fs, v2, lw=1.5, label="|V2| power")
    axes[0].set_ylabel("signal amplitude")
    axes[0].set_title("Two-channel input powers")
    axes[0].grid(True, alpha=0.3)
    axes[0].legend(loc="best")

    axes[1].plot(t_fs, e_float, color="goldenrod", lw=1.4, label="E=(|V1|-|V2|)/(|V1|+|V2|)")
    axes[1].plot(
        t_fs,
        e_quantized,
        color="gray",
        lw=1.0,
        alpha=0.9,
        label=f"error after Q{FP_FRAC_BITS}",
    )
    axes[1].plot(t_fs, z, "k.", ms=2, alpha=0.35, label="measurement z")
    axes[1].plot(t_fs, x_pred, "b-", lw=1.2, label="predicted x^-")
    axes[1].plot(t_fs, x_post, "r-", lw=1.2, label="updated x^+")
    axes[1].set_ylabel("error")
    axes[1].set_title("Kalman output: high power tracks measurement, low power prefers prediction")
    axes[1].grid(True, alpha=0.3)
    axes[1].legend(loc="best")

    axes[2].plot(t_step, p, color="orange", lw=1.2, label="power")
    axes[2].axhline(power_threshold, color="red", ls="--", lw=1, label=f"power_threshold={power_threshold:g}")
    axes[2].fill_between(t_step, 0, np.max(p) + 10.0, where=fade, color="purple", alpha=0.12, label="fade intervals")
    axes[2].set_xlabel("step")
    axes[2].set_ylabel("power")
    axes[2].set_title("Power profile with sudden deep fades")
    axes[2].grid(True, alpha=0.3)
    axes[2].legend(loc="best")

    output_path.parent.mkdir(parents=True, exist_ok=True)
    fig.tight_layout()
    fig.savefig(output_path, dpi=150)
    plt.close(fig)
    return output_path


def evaluate(results: list[StepResult], params: dict) -> str:
    powers = np.array([r.power for r in results])
    gains = np.array([r.gain_k0 for r in results])
    rs = np.array([r.used_r for r in results])
    fade = np.array([r.is_fade for r in results], dtype=bool)

    fade_count = int(np.sum(powers < params["power_threshold"]))
    use_fade_r_count = int(np.sum(rs == params["fade_measurement_noise_std"] ** 2))
    use_base_r_count = len(results) - use_fade_r_count

    mae_pred = np.abs(np.array([r.predicted_x for r in results]) - np.array([r.error_float for r in results]))
    mae_upd = np.abs(np.array([r.state_x for r in results]) - np.array([r.error_float for r in results]))

    normal = ~fade
    fade_mae_pred = float(np.mean(mae_pred[fade])) if np.any(fade) else float("nan")
    fade_mae_upd = float(np.mean(mae_upd[fade])) if np.any(fade) else float("nan")
    normal_mae_pred = float(np.mean(mae_pred[normal])) if np.any(normal) else float("nan")
    normal_mae_upd = float(np.mean(mae_upd[normal])) if np.any(normal) else float("nan")

    return (
        "\n===== Kalman 仿真评估 =====\n"
        f"steps = {len(results)}\n"
        f"power range = [{powers.min():.2f}, {powers.max():.2f}]\n"
        f"power_threshold = {params['power_threshold']}\n"
        f"power < threshold 次数 = {fade_count}\n"
        f"R_base 使用次数 = {use_base_r_count}, R_fade 使用次数 = {use_fade_r_count}\n"
        f"K(时间维) 范围 = [{gains.min():.6f}, {gains.max():.6f}]\n"
        f"正常高功率区 MAE: predict={normal_mae_pred:.4f}, update={normal_mae_upd:.4f}\n"
        f"深衰落区 MAE: predict={fade_mae_pred:.4f}, update={fade_mae_upd:.4f}\n"
    )


def main() -> None:
    parser = argparse.ArgumentParser(description="FPATS Kalman 模块仿真")
    parser.add_argument("--steps", type=int, default=3000, help="仿真步数")
    parser.add_argument("--seed", type=int, default=42, help="随机种子")
    parser.add_argument(
        "--plot-out",
        type=Path,
        default=Path("linien-server/linien_server/artifacts/kalman_io_comparison.png"),
        help="输入输出对照图输出路径",
    )
    parser.add_argument(
        "--power-plot-out",
        type=Path,
        default=Path("linien-server/linien_server/artifacts/v1_v2_power_vs_time.png"),
        help="V1/V2 两路功率-时间图输出路径",
    )
    args = parser.parse_args()

    results, timings, params = run_simulation(steps=args.steps, seed=args.seed)

    print("\n===== 当前项目 Kalman 参数 =====")
    for k, v in params.items():
        if isinstance(v, np.ndarray):
            print(f"{k}: {v.flatten().tolist()}")
        else:
            print(f"{k}: {v}")

    print(evaluate(results, params))
    error_series = np.array([r.error_e for r in results])
    print(f"误差信号范围: [{error_series.min():.4f}, {error_series.max():.4f}], 均值={error_series.mean():.4f}")

    print("===== 计算耗时统计 =====")
    print(summarize_timing("误差信号计算", timings.calc_error_us))
    print(
        summarize_timing(
            f"Q{FP_FRAC_BITS}转换与测量构造",
            timings.convert_us,
        )
    )
    print(summarize_timing("Kalman predict", timings.predict_us))
    print(summarize_timing("Kalman update", timings.update_us))
    print(summarize_timing("单步总耗时", timings.total_us))

    saved_power = save_v1_v2_power_plot(results, args.power_plot_out)
    print(f"\nV1/V2功率-时间图已保存: {saved_power}")

    saved = save_comparison_plot(results, args.plot_out, power_threshold=float(params["power_threshold"]))
    print(f"对照图已保存: {saved}")


if __name__ == "__main__":
    main()
