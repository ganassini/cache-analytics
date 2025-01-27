#!/usr/bin/python

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

split = pd.read_csv("data/gcc/split.csv")
unified = pd.read_csv("data/gcc/unified.csv")

split_cache_size = split["cache_size"]
split_misses = split["il1_misses"] + split["dl1_misses"]

unified_cache_size = unified["cache_size"]
unified_misses = unified["misses"]

bar_width = 0.4

x_positions = np.arange(len(split_cache_size))

plt.figure(figsize=(10, 6))
plt.bar(x_positions - bar_width / 2, split_misses, width=bar_width, label="Misses Cache Separada", color="blue")
plt.bar(x_positions + bar_width / 2, unified_misses, width=bar_width, label="Misses Cache Unificada", color="orange")

plt.xticks(x_positions, [f"{size}" for size in split_cache_size], rotation=45)
plt.xlabel("Tamanho da cache (Bytes)")
plt.ylabel("Misses")
plt.title("Comparação de Misses Cache Separada e Unificada GCC_4")
plt.legend()
plt.grid(axis="y", linestyle="--", linewidth=0.5)

plt.tight_layout()
plt.show()

