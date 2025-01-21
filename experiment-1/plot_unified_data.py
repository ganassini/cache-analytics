#!/usr/bin/python

import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv("data/go_unified.csv")

pivot_table = data.pivot(index='n_sets',
                         columns='assoc',
                         values='ul1_misses')

plt.figure(figsize=(10, 6))
for assoc in pivot_table.columns:
    plt.plot(pivot_table.index,
             pivot_table[assoc],
             marker='o',
             label=f"Assoc {assoc}")

plt.title("Relação entre número de misses, conjuntos e associatividade",
          fontsize=14)
plt.xlabel("Conjuntos", fontsize=12)
plt.ylabel("Misses", fontsize=12)
plt.grid(True, linestyle="--", alpha=0.6)
plt.legend(title="Associatividade")
plt.xticks(pivot_table.index)

plt.tight_layout()
plt.savefig("go_unified_plot.png")
plt.show()
