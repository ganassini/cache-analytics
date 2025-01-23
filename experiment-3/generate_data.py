#!/usr/bin/python
 
from os import system


def lru(benchmark):
    # testes de 1KiB até 256KiB
    tests = ["8 8", "16 16", "32 32", "64 64", "128 128"]
    
    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc l " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go l " + test
            system(commandline)
        return 


def fifo(benchmark):
    # testes de 1KiB até 256KiB
    tests = ["8 8", "16 16", "32 32", "64 64", "128 128"]

    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc f " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go f " + test
            system(commandline)
        return


def random(benchmark):
    # testes de 1KiB até 256KiB
    tests = ["8 8", "16 16", "32 32", "64 64", "128 128"]
    
    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc r " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go r " + test
            system(commandline)
        return


if __name__ == "__main__":
    lru("gcc")
    lru("go")
    fifo("gcc")
    fifo("go")
    random("gcc")
    random("go")
