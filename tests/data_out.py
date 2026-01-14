import pickle
import pandas as pd

pkl_path = r"E:\testlinien\FPATS\data\plot_data_20260113_185058.pkl"

with open(pkl_path, "rb") as f:
    data = pickle.load(f)

rows = []
for t, payload in data:
    d = pickle.loads(payload)
    d["t"] = t
    rows.append(d)

df = pd.DataFrame(rows).sort_values("t")

df.to_csv(r"E:\testlinien\FPATS\data\plot_data.csv", index=False, encoding="utf-8-sig")
df.to_excel(r"E:\testlinien\FPATS\data\plot_data.xlsx", index=False)

print("Saved:")
print(r"E:\testlinien\FPATS\data\plot_data.csv")
print(r"E:\testlinien\FPATS\data\plot_data.xlsx")
