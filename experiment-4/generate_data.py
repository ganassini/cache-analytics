#!/usr/bin/python
 
from os import system


def s_128(benchmark):
    if benchmark == "gcc":
        for i in range(3, 12):
            commandline = "./run.sh gcc " + str(2**i) + " 128"
            system(commandline)
        return

    if benchmark == "go":
        for i in range(3, 12):
            commandline = "./run.sh go " + str(2**i) + " 128"
            system(commandline)
        return 


def s_256(benchmark):
    if benchmark == "gcc":
        for i in range(3, 12):
            commandline = "./run.sh gcc " + str(2**i) + " 256"
            system(commandline)
        return

    if benchmark == "go":
        for i in range(3, 12):
            commandline = "./run.sh go " + str(2**i) + " 256"
            system(commandline)
        return 


def s_512(benchmark):
    if benchmark == "gcc":
        for i in range(3, 12):
            commandline = "./run.sh gcc " + str(2**i) + " 512"
            system(commandline)
        return

    if benchmark == "go":
        for i in range(3, 12):
            commandline = "./run.sh go " + str(2**i) + " 512"
            system(commandline)
        return 

def s_1024(benchmark):
    if benchmark == "gcc":
        for i in range(3, 12):
            commandline = "./run.sh gcc " + str(2**i) + " 1024"
            system(commandline)
        return

    if benchmark == "go":
        for i in range(3, 12):
            commandline = "./run.sh go " + str(2**i) + " 1024"
            system(commandline)
        return 

if __name__ == "__main__":
    s_128("gcc")
    s_128("go")
    s_256("gcc")
    s_256("go")
    s_512("gcc")
    s_512("go")
    s_1024("gcc")
    s_1024("go")
