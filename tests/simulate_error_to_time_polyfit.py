from __future__ import annotations

import argparse
import csv
from dataclasses import dataclass
from pathlib import Path

import numpy as np


@dataclass
class SimulationConfig:
    time_min_fs: float = -1500.0
    time_max_fs: float = 1500.0
    num_points: int = 3001
    fit_region_fs: float = 300.0
    sigma_fs: float = 280.0
    center_offset_fs: float = 320.0
    amplitude: float = 0.05
    baseline: float = 0.002
    poly_order: int = 3
    use_odd_terms_only: bool = True
    noise_std_e: float = 0.0
    random_seed: int = 42
    plot_out: str = "data/error_to_time_polyfit.png"
    csv_out: str = "data/error_to_time_polyfit.csv"


def gaussian_envelope(t_fs: np.ndarray, center_fs: float, sigma_fs: float, amplitude: float, baseline: float) -> np.ndarray:
    return baseline + amplitude * np.exp(-((t_fs - center_fs) ** 2) / (2.0 * sigma_fs**2))


def calc_error_signal(v1: np.ndarray, v2: np.ndarray) -> np.ndarray:
    numerator = np.abs(v1) - np.abs(v2)
    denominator = np.abs(v1) + np.abs(v2)
    safe_denominator = np.where(denominator > 0, denominator, 1.0)
    return numerator / safe_denominator


def build_dataset(cfg: SimulationConfig) -> tuple[np.ndarray, np.ndarray, np.ndarray, np.ndarray]:
    rng = np.random.default_rng(cfg.random_seed)
    t_fs = np.linspace(cfg.time_min_fs, cfg.time_max_fs, cfg.num_points)
    v1 = gaussian_envelope(
        t_fs,
        center_fs=cfg.center_offset_fs,
        sigma_fs=cfg.sigma_fs,
        amplitude=cfg.amplitude,
        baseline=cfg.baseline,
    )
    v2 = gaussian_envelope(
        t_fs,
        center_fs=-cfg.center_offset_fs,
        sigma_fs=cfg.sigma_fs,
        amplitude=cfg.amplitude,
        baseline=cfg.baseline,
    )
    e = calc_error_signal(v1, v2)
    if cfg.noise_std_e > 0:
        e = e + rng.normal(0.0, cfg.noise_std_e, size=e.shape)
        e = np.clip(e, -1.0, 1.0)
    return t_fs, v1, v2, e


def build_design_matrix(e: np.ndarray, poly_order: int, use_odd_terms_only: bool) -> tuple[np.ndarray, list[int]]:
    if use_odd_terms_only:
        powers = [p for p in range(1, poly_order + 1) if p % 2 == 1]
    else:
        powers = list(range(0, poly_order + 1))

    if not powers:
        raise ValueError("No polynomial powers selected for fitting.")

    x = np.column_stack([e**p for p in powers])
    return x, powers


def fit_time_from_error(e_fit: np.ndarray, t_fit_fs: np.ndarray, poly_order: int, use_odd_terms_only: bool) -> tuple[np.ndarray, list[int]]:
    design_matrix, powers = build_design_matrix(e_fit, poly_order, use_odd_terms_only)
    coeffs, *_ = np.linalg.lstsq(design_matrix, t_fit_fs, rcond=None)
    return coeffs, powers


def eval_polynomial(e: np.ndarray, coeffs: np.ndarray, powers: list[int]) -> np.ndarray:
    y = np.zeros_like(e, dtype=float)
    for coeff, power in zip(coeffs, powers):
        y += coeff * (e**power)
    return y


def summarize_residuals(t_true_fs: np.ndarray, t_est_fs: np.ndarray) -> dict[str, float]:
    residual = t_est_fs - t_true_fs
    return {
        "mean_fs": float(np.mean(residual)),
        "std_fs": float(np.std(residual)),
        "rms_fs": float(np.sqrt(np.mean(residual**2))),
        "max_abs_fs": float(np.max(np.abs(residual))),
    }


def save_plot(
    output_path: Path,
    t_fs: np.ndarray,
    v1: np.ndarray,
    v2: np.ndarray,
    e: np.ndarray,
    t_est_full_fs: np.ndarray,
    fit_mask: np.ndarray,
) -> None:
    try:
        import matplotlib

        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
    except Exception as exc:
        print(f"Plot skipped: matplotlib unavailable ({exc})")
        return

    fig, axes = plt.subplots(3, 1, figsize=(10, 11))

    axes[0].plot(t_fs, v1, label="|V1|")
    axes[0].plot(t_fs, v2, label="|V2|")
    axes[0].set_xlabel("Time offset (fs)")
    axes[0].set_ylabel("Amplitude (a.u.)")
    axes[0].set_title("Two discriminator channel envelopes")
    axes[0].grid(True, alpha=0.3)
    axes[0].legend(loc="best")

    axes[1].plot(t_fs, e, color="tab:orange", label="E")
    axes[1].fill_between(
        t_fs,
        np.min(e),
        np.max(e),
        where=fit_mask,
        color="tab:purple",
        alpha=0.12,
        label="fit region",
    )
    axes[1].set_xlabel("Time offset (fs)")
    axes[1].set_ylabel("Error signal")
    axes[1].set_title("Discriminator error signal")
    axes[1].grid(True, alpha=0.3)
    axes[1].legend(loc="best")

    axes[2].plot(t_fs, t_fs, label="True $\\delta t$")
    axes[2].plot(t_fs, t_est_full_fs, label="Estimated $\\delta t=f(E)$", linestyle="--")
    axes[2].set_xlabel("True time offset (fs)")
    axes[2].set_ylabel("Estimated time offset (fs)")
    axes[2].set_title("Polynomial inverse mapping")
    axes[2].grid(True, alpha=0.3)
    axes[2].legend(loc="best")

    output_path.parent.mkdir(parents=True, exist_ok=True)
    fig.tight_layout()
    fig.savefig(output_path, dpi=160)
    plt.close(fig)


def save_csv(
    output_path: Path,
    t_fs: np.ndarray,
    v1: np.ndarray,
    v2: np.ndarray,
    e: np.ndarray,
    t_est_full_fs: np.ndarray,
) -> None:
    output_path.parent.mkdir(parents=True, exist_ok=True)
    with output_path.open("w", newline="", encoding="utf-8") as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow(
            [
                "time_offset_fs",
                "v1",
                "v2",
                "error_signal_E",
                "estimated_time_offset_fs",
            ]
        )
        for row in zip(t_fs, v1, v2, e, t_est_full_fs):
            writer.writerow(row)


def run_simulation(cfg: SimulationConfig) -> None:
    t_fs, v1, v2, e = build_dataset(cfg)
    fit_mask = np.abs(t_fs) <= cfg.fit_region_fs

    e_fit = e[fit_mask]
    t_fit_fs = t_fs[fit_mask]
    coeffs, powers = fit_time_from_error(
        e_fit=e_fit,
        t_fit_fs=t_fit_fs,
        poly_order=cfg.poly_order,
        use_odd_terms_only=cfg.use_odd_terms_only,
    )

    t_est_fit_fs = eval_polynomial(e_fit, coeffs, powers)
    t_est_full_fs = eval_polynomial(e, coeffs, powers)
    metrics_fit = summarize_residuals(t_fit_fs, t_est_fit_fs)

    print("=== Polynomial Fit Result ===")
    print(f"fit region: |delta_t| <= {cfg.fit_region_fs:.1f} fs")
    print(f"poly order: {cfg.poly_order}")
    print(f"powers used: {powers}")
    print("coefficients (delta_t in fs):")
    for coeff, power in zip(coeffs, powers):
        print(f"  a{power} = {coeff:.12g}")

    print("\n=== Fit Residuals In Working Region ===")
    for key, value in metrics_fit.items():
        print(f"  {key}: {value:.6f}")

    print("\n=== Example Online Model ===")
    terms = [f"({coeff:.8g}) * E^{power}" for coeff, power in zip(coeffs, powers)]
    print("delta_t_fs = " + " + ".join(terms))

    plot_path = Path(cfg.plot_out)
    csv_path = Path(cfg.csv_out)
    save_plot(
        output_path=plot_path,
        t_fs=t_fs,
        v1=v1,
        v2=v2,
        e=e,
        t_est_full_fs=t_est_full_fs,
        fit_mask=fit_mask,
    )
    save_csv(
        output_path=csv_path,
        t_fs=t_fs,
        v1=v1,
        v2=v2,
        e=e,
        t_est_full_fs=t_est_full_fs,
    )
    print(f"\nplot saved to: {plot_path}")
    print(f"csv saved to: {csv_path}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Simulate E-to-delta_t polynomial calibration.")
    parser.add_argument("--fit-region-fs", type=float, default=300.0, help="Use only |delta_t| <= this value for fitting.")
    parser.add_argument("--poly-order", type=int, default=3, help="Polynomial order.")
    parser.add_argument("--all-terms", action="store_true", help="Use all polynomial terms instead of odd-only terms.")
    parser.add_argument("--noise-std-e", type=float, default=0.0, help="Optional additive noise on E.")
    parser.add_argument(
        "--plot-out",
        type=Path,
        default=Path("data/error_to_time_polyfit.png"),
        help="Optional output plot path.",
    )
    parser.add_argument(
        "--csv-out",
        type=Path,
        default=Path("data/error_to_time_polyfit.csv"),
        help="Optional output csv path.",
    )
    args = parser.parse_args()

    cfg = SimulationConfig(
        fit_region_fs=args.fit_region_fs,
        poly_order=args.poly_order,
        use_odd_terms_only=not args.all_terms,
        noise_std_e=args.noise_std_e,
        plot_out=str(args.plot_out),
        csv_out=str(args.csv_out),
    )
    run_simulation(cfg)


def run_with_default_config() -> None:
    """Convenience entry for Windows/IDE users who want to run without CLI args."""
    cfg = SimulationConfig()
    run_simulation(cfg)


if __name__ == "__main__":
    main()
