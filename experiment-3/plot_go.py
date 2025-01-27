#!/usr/bin/python

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

files = ["data/go/lru.csv",
         "data/go/fifo.csv",
         "data/go/random.csv"]

labels = ["LRU", "FIFO", "Random"]

data = {}
for file, label in zip(files, labels):
    df = pd.read_csv(file)
    data[label] = (df["cache_size"], df["miss_rate"])

cache_sizes = list(data[labels[0]][0])
x = np.arange(len(cache_sizes))
width = 0.2

plt.figure(figsize=(12, 6))
for i, label in enumerate(labels):
    _, miss_rate = data[label]
    plt.bar(x + i * width, miss_rate, width, label=label)

plt.title("Taxa de Misses por Algoritmo de Substituição GO_1")
plt.xlabel("Tamanho da Cache (Bytes)")
plt.ylabel("Taxa de Misses")
plt.xticks(x + width * (len(labels) - 1) / 2, cache_sizes)
plt.legend(title="Algoritmo de Substituição")
plt.grid(axis="y", linestyle="--", linewidth=0.5)
plt.tight_layout()

plt.show()
