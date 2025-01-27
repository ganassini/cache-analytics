#!/usr/bin/python

import pandas as pd
import matplotlib.pyplot as plt

csv_files = ["data/gcc/direct.csv",
             "data/gcc/8_way.csv",
             "data/gcc/16_way.csv",
             "data/gcc/fully_associative.csv"]

labels = ["Direct Mapping", "8-Way Mapping", "16-Way Mapping", "Fully Associative"]

miss_ratios = []
for file in csv_files:
    df = pd.read_csv(file)
    miss_ratios.append(df["miss_rate"].tolist())

miss_ratios_by_line = list(zip(*miss_ratios))

plt.figure(figsize=(14, 8))
bar_width = 0.2
x = range(len(miss_ratios_by_line))

for i, label in enumerate(labels):
    bar_positions = [pos + i * bar_width for pos in x]
    ratios = [line[i] for line in miss_ratios_by_line]
    plt.bar(bar_positions, ratios, bar_width, label=label)

plt.xticks([pos + (bar_width * 1.5) for pos in x], [f"Line {i + 1}" for i in x])
plt.xlabel("Cache Lines")
plt.ylabel("Miss Ratio")
plt.title("Impact of Cache Associativity on Miss Ratio")
plt.legend()

for i, label in enumerate(labels):
    bar_positions = [pos + i * bar_width for pos in x]
    ratios = [line[i] for line in miss_ratios_by_line]
    for pos, ratio in zip(bar_positions, ratios):
        plt.text(pos, ratio + 0.005, f"{ratio:.4f}", ha='center', fontsize=8)

plt.tight_layout()
plt.show()
