# open_pkl.py
# 用法：
#   python open_pkl.py
#   python open_pkl.py --path /mnt/data/plot_data_20260113_185058.pkl --to_csv out.csv --plot
#
# ⚠️ 安全提示：不要对不可信来源的 .pkl 文件执行 pickle.load / loads（可能触发任意代码执行）

import argparse
import pickle
from pathlib import Path


def load_pkl(path: str):
    p = Path(path)
    if not p.exists():
        raise FileNotFoundError(f"File not found: {p.resolve()}")
    with p.open("rb") as f:
        return pickle.load(f)


def try_nested_unpack(obj):
    """
    针对你这个文件的常见结构：
      obj = [(t, payload_bytes), ...]
      payload_bytes = pickle.dumps(dict_like)
    返回 (records, kind)
      records: list[dict]，每条包含 t
      kind: 字符串描述
    """
    if not isinstance(obj, list) or len(obj) == 0:
        return None, "not_list_or_empty"

    first = obj[0]
    if (
        isinstance(first, tuple)
        and len(first) == 2
        and isinstance(first[1], (bytes, bytearray))
    ):
        records = []
        ok = 0
        bad = 0
        for t, payload in obj:
            try:
                d = pickle.loads(payload)
                if isinstance(d, dict):
                    d = dict(d)
                    d["t"] = t
                    records.append(d)
                    ok += 1
                else:
                    # payload 解出来不是 dict，也照样记录
                    records.append({"t": t, "value": d})
                    ok += 1
            except Exception as e:
                records.append({"t": t, "error": repr(e)})
                bad += 1
        return records, f"list_of_(t, pickled_bytes) ok={ok} bad={bad}"

    return None, "unknown_structure"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument(
        "--path",
        default="E:/testlinien/FPATS/data/plot_data_20260113_185058.pkl",
        help="pkl 文件路径",
    )
    ap.add_argument("--to_csv", default="", help="若提供则保存为 CSV 文件路径")
    ap.add_argument("--plot", action="store_true", help="若可用则画图（需要 pandas+matplotlib）")
    args = ap.parse_args()

    obj = load_pkl(args.path)
    print(f"[1] Loaded: {args.path}")
    print(f"    type = {type(obj)}")
    if hasattr(obj, "__len__"):
        try:
            print(f"    len  = {len(obj)}")
        except Exception:
            pass

    # 尝试按你这个文件的“二层 pickle”结构展开
    records, kind = try_nested_unpack(obj)
    print(f"[2] Parse kind: {kind}")

    if records is None:
        # 结构不匹配就直接打印一小段预览
        print("[3] Preview (repr, first 2 items if possible):")
        try:
            if isinstance(obj, list):
                print(obj[:2])
            else:
                print(repr(obj)[:2000])
        except Exception as e:
            print("Preview failed:", e)
        return

    # 有 records：转成 DataFrame（如果 pandas 可用）
    try:
        import pandas as pd

        df = pd.DataFrame(records)
        if "t" in df.columns:
            df = df.set_index("t").sort_index()

        print("[3] DataFrame preview:")
        print(df.head())

        if args.to_csv:
            out = Path(args.to_csv)
            df.to_csv(out, index=True)
            print(f"[4] Saved CSV to: {out.resolve()}")

        if args.plot:
            import matplotlib.pyplot as plt

            ax = df.plot()
            ax.set_title("PKL data")
            ax.set_xlabel("t")
            plt.show()

    except ImportError:
        print("[3] pandas 未安装，改为打印前 5 条 records：")
        for r in records[:5]:
            print(r)

        if args.to_csv:
            # 简单 CSV 输出（无 pandas）
            import csv

            out = Path(args.to_csv)
            keys = sorted({k for r in records for k in r.keys()})
            with out.open("w", newline="", encoding="utf-8") as f:
                w = csv.DictWriter(f, fieldnames=keys)
                w.writeheader()
                w.writerows(records)
            print(f"[4] Saved CSV to: {out.resolve()}")


if __name__ == "__main__":
    main()
