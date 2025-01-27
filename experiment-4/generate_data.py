#!/usr/bin/python
 
from os import system


def s_128(benchmark):
    tests = ["32 128", "64 128", "128 128", "256 128", "512 128"]

    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go " + test
            system(commandline)
        return 


def s_256(benchmark):
    tests = ["16 256", "32 256", "64 256", "128 256", "256 256"]

    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go " + test
            system(commandline)
        return 


def s_512(benchmark):
    tests = ["8 512", "16 512", "32 512", "64 512", "128 512"]

    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go " + test
            system(commandline)
        return 

def s_1024(benchmark):
    tests = ["4 1024", "8 1024", "16 1024", "32 1024", "64 1024"]

    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go " + test
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
