# plot_csv_curve.py
# 直接读取并绘制：E:\testlinien\plotdata\20260130_085930_505550.csv
# 运行方式：
#   python plot_csv_curve.py
#
# 可选项（在下面“参数区”修改即可）：
#   - 只画部分列：Y_COLS = [...]
#   - 转时区：TO_TIMEZONE = "Asia/Singapore"
#   - 平滑：ROLLING = 5
#   - 分开子图：SEPARATE = True
#   - 保存图片：SAVE_PATH = "out.png"

import pandas as pd
import matplotlib.pyplot as plt

# ---------------- 参数区 ----------------
CSV_PATH = r"E:\testlinien\plotdata\20260130_085930_505550.csv"

# x 轴列名：优先用 timestamp_utc；如果你的 CSV 不是这个列名，可改成别的
X_COL = "timestamp_utc"

# y 轴列名：None 表示自动选择（优先 power_signal/power_signal_a/power_signal_b，
# 再不行就画所有数值列）
Y_COLS = None  # 例如：["power_signal", "power_signal_a", "power_signal_b"]

# 是否把 UTC 时间转换到指定时区（例如 "Asia/Singapore"）；None 表示不转换
TO_TIMEZONE = None  # 例如："Asia/Singapore"

# 滚动平均平滑窗口（点数）；<=1 表示不平滑
ROLLING = 0  # 例如：5

# True：每个 y 单独子图；False：画在同一张图
SEPARATE = False

# 保存图片路径；None 表示不保存只显示
SAVE_PATH = None  # 例如："out.png"
# --------------------------------------


def pick_default_y_cols(df: pd.DataFrame) -> list[str]:
    preferred = ["power_signal", "power_signal_a", "power_signal_b"]
    exist = [c for c in preferred if c in df.columns]
    if exist:
        return exist
    # 否则用所有数值列（排除 x）
    numeric_cols = df.select_dtypes(include="number").columns.tolist()
    return [c for c in numeric_cols if c != X_COL] if X_COL in df.columns else numeric_cols


def build_x(df: pd.DataFrame):
    if X_COL in df.columns:
        # 如果是时间戳列，尝试解析为 datetime (UTC)
        if "time" in X_COL.lower() or "timestamp" in X_COL.lower() or X_COL.lower() in ["t", "datetime"]:
            x = pd.to_datetime(df[X_COL], utc=True, errors="coerce")
            if TO_TIMEZONE:
                x = x.dt.tz_convert(TO_TIMEZONE)
                x_label = f"{X_COL} ({TO_TIMEZONE})"
            else:
                x_label = f"{X_COL} (UTC)"
            return x, x_label
        else:
            return df[X_COL], X_COL
    # 没有 x 列就用行号
    return df.index, "index"


def main():
    # 读取数据
    df = pd.read_csv(CSV_PATH)

    # 构造 x
    x, x_label = build_x(df)

    # 选择 y 列
    y_cols = Y_COLS if (Y_COLS and len(Y_COLS) > 0) else pick_default_y_cols(df)
    if not y_cols:
        raise ValueError("没有找到可绘制的列。请检查 CSV 或手动设置 Y_COLS。")

    # 可选平滑
    plot_df = df.copy()
    if isinstance(ROLLING, int) and ROLLING > 1:
        for c in y_cols:
            if c in plot_df.columns:
                plot_df[c] = plot_df[c].rolling(window=ROLLING, min_periods=1).mean()

    # 绘图
    if SEPARATE:
        fig, axes = plt.subplots(len(y_cols), 1, figsize=(10, 3 * len(y_cols)), sharex=True)
        if len(y_cols) == 1:
            axes = [axes]
        for ax, col in zip(axes, y_cols):
            ax.plot(x, plot_df[col])
            ax.set_ylabel(col)
            ax.grid(True, alpha=0.3)
        axes[-1].set_xlabel(x_label)
        fig.suptitle("CSV Curves", y=0.98)
        fig.tight_layout()
    else:
        plt.figure(figsize=(10, 5))
        for col in y_cols:
            plt.plot(x, plot_df[col], label=col)
        plt.xlabel(x_label)
        plt.ylabel("value")
        plt.title("CSV Curves")
        plt.grid(True, alpha=0.3)
        plt.legend()
        plt.tight_layout()

    # 保存/显示
    if SAVE_PATH:
        plt.savefig(SAVE_PATH, dpi=200, bbox_inches="tight")
        print(f"Saved: {SAVE_PATH}")

    plt.show()


if __name__ == "__main__":
    main()
