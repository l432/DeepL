import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# INPUT_FILE = "ExpTestResult.dat" 
# INPUT_FILE = "ExpTrainResult.dat"
# INPUT_FILE = "MedianTestResult.dat"
# INPUT_FILE = "MedianTrainResult.dat"
INPUT_FILE = "ExpResult.dat"
METRIC = "MRE"                     # "MSEn" | "MedRE" | "R2" | "MRE"
OUTPUT_PNG = f"{METRIC}.png"

# в ОТОБРАЖАЕМЫХ единицах!
# R2: 0..1; MSEn: ×10^-3; MRE/MedRE: % (None - если автоматически)
USER_VMIN = None
USER_VMAX = 20

ML_ORDER = ["SVR", "GB", "RF", "DNN", "XGB"]

CV_CODE_TO_LABEL = {
    "EfC": "EfficientNetC",
    "EfP": "EfficientNetP",
    "EfPp": "EfficientNetP:PCA",
    "MbC": "MobileNetC",
    "MbP": "MobileNetP",
    "MbPp": "MobileNetP:PCA",
    "NNC": "NASNetC",
    "NNCp": "NASNetC:PCA",
    "NNP": "NASNetP",
    "RsC": "ResNetC",
    "RsP": "ResNetP",
    "XcC": "XceptionC",
    "XcP": "XceptionP",
    "YOL": "YOLO",
    "YOL2": "YOLO2",
    "YOfl2p": "YOLOFL2:PCA",
    "YOflp": "YOLOFL:PCA",
    "YOfl": "YOLOfl",
    "YOfl2": "YOLOFL2",
}
CV_ORDER_CODES = [
    "EfC", "EfP", "EfPp",
    "MbC", "MbP", "MbPp",
    "NNC", "NNCp", "NNP",
    "RsC", "RsP",
    "XcC", "XcP",
    "YOL", "YOL2",
    "YOfl2p", "YOflp", "YOfl", "YOfl2",
]
CV_ORDER = [CV_CODE_TO_LABEL[c] for c in CV_ORDER_CODES]
CV_KEYS_DESC = sorted(CV_CODE_TO_LABEL.keys(), key=len, reverse=True)


def parse_ml_and_cv(model_name: str):
    if not isinstance(model_name, str):
        return None, None
    s = model_name
    for prefix in ("Train", "Test"):
    #for prefix in ("Train", "Test", "ExpTrain", "ExpTest"):
        if s.startswith(prefix):
            s = s[len(prefix):]
            break
    if s.startswith("Gb"):
        ml, rest = "GB", s[2:]
    elif s.startswith("Rf"):
        ml, rest = "RF", s[2:]
    elif s.startswith("Xg"):
        ml, rest = "XGB", s[2:]
    elif s.startswith("Sv"):
        ml, rest = "SVR", s[2:]
    else:
        ml, rest = "DNN", s
    cv_label = None
    for key in CV_KEYS_DESC:
        if rest.endswith(key):
            cv_label = CV_CODE_TO_LABEL[key]
            break
    return ml, cv_label

def scale_factor(metric: str) -> float:
    if metric in ("MSEn",):
        return 1e3           
    if metric in ("MRE", "MedRE"):
        return 100.0         
    return 1.0

def cbar_unit_suffix(metric: str) -> str:
    if metric == "MSEn":
        return " ×10⁻³"
    if metric in ("MRE", "MedRE"):
        return ", %"
    return ""

def format_cell_value_from_scaled(scaled_val: float, metric: str) -> str:
    if metric == "R2":
        return f"{scaled_val:.3f}"
    elif metric in ("MSEn",):
        return f"{scaled_val:.1f}"
    elif metric in ("MRE", "MedRE"):
        return f"{scaled_val:.0f}" if scaled_val >= 50 else f"{scaled_val:.1f}"
    else:
        return f"{scaled_val:.2f}"

def format_boundary_number(scaled_val: float, metric: str) -> str:
    if metric == "R2":
        return f"{scaled_val:.3f}"
    elif metric in ("MSEn", "MRE", "MedRE"):
        return f"{round(scaled_val):.0f}"
    else:
        return f"{scaled_val:.2f}"

def compute_auto_bounds(finite_vals_raw: np.ndarray, metric: str):
    sf = scale_factor(metric)
    vals = finite_vals_raw * sf
    if metric == "R2":
        positives = vals[vals > 0]
        vmin = positives.min() if positives.size > 0 else vals.min()
        less_than_one = vals[vals < 1]
        vmax = less_than_one.max() if less_than_one.size > 0 else vals.max()
    else:
        vmin, vmax = vals.min(), vals.max()
    return float(vmin), float(vmax)

def main():
    if not os.path.exists(INPUT_FILE):
        raise FileNotFoundError(f"Нет файла: {os.path.abspath(INPUT_FILE)}")

    df = pd.read_csv(INPUT_FILE, sep="\t", dtype=str)
    df["ML"], df["CV"] = zip(*df["Model"].map(parse_ml_and_cv))
    df = df[df["ML"].isin(ML_ORDER) & df["CV"].isin(CV_ORDER)].copy()
    df[METRIC] = pd.to_numeric(df[METRIC], errors="coerce")

    mat = pd.DataFrame(index=CV_ORDER, columns=ML_ORDER, dtype=float)
    for _, row in df.iterrows():
        mat.at[row["CV"], row["ML"]] = row[METRIC]

    values_raw = mat.values.astype(float)
    finite_raw = values_raw[np.isfinite(values_raw)]
    if finite_raw.size == 0:
        raise RuntimeError("Всё плохо")

    sf = scale_factor(METRIC)
    values_display = values_raw * sf
    masked_display = np.ma.array(values_display, mask=np.isnan(values_raw))

    vmin_auto, vmax_auto = compute_auto_bounds(finite_raw, METRIC)
    vmin = float(USER_VMIN) if USER_VMIN is not None else vmin_auto
    vmax = float(USER_VMAX) if USER_VMAX is not None else vmax_auto

    if vmin >= vmax:
        raise ValueError("USER_VMIN должен быть < USER_VMAX")

    vmin_label = format_boundary_number(vmin, METRIC)
    vmax_label = format_boundary_number(vmax, METRIC)

    cbar_label = METRIC + cbar_unit_suffix(METRIC)

    cmap = plt.cm.viridis.copy()
    cmap.set_bad((1, 1, 1, 0))

    fig, ax = plt.subplots(figsize=(10, 8))
    im = ax.imshow(masked_display, cmap=cmap, vmin=vmin, vmax=vmax, aspect="auto")

    ax.set_xticks(np.arange(len(ML_ORDER)))
    ax.set_xticklabels(ML_ORDER)
    ax.set_yticks(np.arange(len(CV_ORDER)))
    ax.set_yticklabels(CV_ORDER)

    for i in range(values_display.shape[0]):
        for j in range(values_display.shape[1]):
            sd = values_display[i, j]
            if np.isnan(sd):
                continue
            if sd < vmin:
                text = f"<{vmin_label}"
            elif sd > vmax:
                text = f">{vmax_label}"
            else:
                text = format_cell_value_from_scaled(sd, METRIC)
            ax.text(j, i, text, ha="center", va="center", fontsize=12, color="white")

    cbar = fig.colorbar(im, ax=ax)
    ticks = np.linspace(vmin, vmax, num=5)
    tick_labels = []
    for k, t in enumerate(ticks):
        if k == 0 or k == len(ticks) - 1:
            tick_labels.append(format_boundary_number(t, METRIC))
        else:
            if METRIC == "R2":
                tick_labels.append(f"{t:.3f}")
            elif METRIC in ("MSEn",):
                tick_labels.append(f"{t:.1f}")
            elif METRIC in ("MRE", "MedRE"):
                tick_labels.append(f"{t:.1f}")
            else:
                tick_labels.append(f"{t:.2f}")
    cbar.set_ticks(ticks)
    cbar.ax.set_yticklabels(tick_labels)
    cbar.set_label(cbar_label)

    ax.set_title(f"Heatmap for {cbar_label}")
    plt.tight_layout()
    plt.savefig(OUTPUT_PNG, dpi=300, facecolor="white")
    print(f"Saved: {os.path.abspath(OUTPUT_PNG)}")

if __name__ == "__main__":
    main()
