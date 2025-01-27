#!/usr/bin/python

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

files = ["data/gcc/s_128.csv",
         "data/gcc/s_256.csv",
         "data/gcc/s_512.csv",
         "data/gcc/s_1024.csv"]

labels = ["128", "256", "512", "1024"]

data = {}
for file, label in zip(files, labels):
    df = pd.read_csv(file)
    data[label] = (df["cache_size"], df["il1_miss_rate"])

cache_sizes = list(data[labels[0]][0])
x = np.arange(len(cache_sizes))
width = 0.1

plt.figure(figsize=(12, 6))
for i, label in enumerate(labels):
    _, miss_rate = data[label]
    plt.bar(x + i * width, miss_rate, width, label=label)

plt.title("Numero de Misses iL1 por Tamanho do Bloco GCC_4")
plt.xlabel("Tamanho da Cache (Bytes)")
plt.ylabel("Taxa de Miss")
plt.xticks(x + width * (len(labels) - 1) / 2, cache_sizes)
plt.legend(title="Tamanho do Bloco")
plt.grid(axis="y", linestyle="--", linewidth=0.5)
plt.tight_layout()

plt.show()


