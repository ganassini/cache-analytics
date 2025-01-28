#!/usr/bin/python

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

sl2 = pd.read_csv("data/gcc/sl2.csv")
ul2 = pd.read_csv("data/gcc/ul2.csv")

sl2['total_misses'] = sl2['il1_misses'] + sl2['il2_misses'] + sl2['dl1_misses'] + sl2['dl2_misses']
ul2['total_misses'] = ul2['il1_misses'] + ul2['dl1_misses'] + ul2['dl2_misses']

x = np.arange(len(sl2))
width = 0.35

plt.bar(x - width / 2, sl2['total_misses'], width, label='L2 Separada')
plt.bar(x + width / 2, ul2['total_misses'], width, label='L2 Unificada')

plt.xlabel('Tamanho da Cache')
plt.ylabel('Numero de Misses')
plt.title('Numero de Misses por Tipo de Cache GCC_4')
plt.xticks(x, sl2['l2_cache_size'], rotation=45)
plt.legend()

plt.tight_layout()
plt.show()

