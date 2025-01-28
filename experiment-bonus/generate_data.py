#!/usr/bin/python
 
from os import system


def split(benchmark):
    tests = ["8", "16", "32"]
    
    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc s " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go s " + test
            system(commandline)
        return 


def unified(benchmark):
    tests = ["8", "16", "32"]
    
    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc u " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go u " + test
            system(commandline)
        return


if __name__ == "__main__":
    split("gcc")
    split("go")
    unified("gcc")
    unified("go")
