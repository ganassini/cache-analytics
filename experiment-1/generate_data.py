#!/usr/bin/python
#
# TODO ta errado tem q fazer uns tamanho menorzinho

from os import system

for i in range(1, 11):
    k = 2**i
    for j in range(1, 11):
        l = 2**j
        commandline = "./run.sh go " + str(k) + " " + str(l)
        system(commandline)
