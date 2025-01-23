#!/usr/bin/python
 
from os import system


def direct_mapping(benchmark):
    # testes de 1KiB até 128KiB
    tests = ["64 1", "128 1", "256 1", "512 1", "1024 1", "2048 1", "4096 1", "8192 1"]
    
    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc d " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go d " + test
            system(commandline)
        return 


def fully_associative(benchmark):
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


def eight_way(benchmark):
    # testes de 1KiB até 256KiB
    tests = ["8 8", "16 8", "32 8", "64 8", "128, 8",
             "256 8", "512 8", "1024 8", "2048 8"]
    
    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc 8 " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go 8 " + test
            system(commandline)
        return


def sixteen_way(benchmark):
    # testes de 1KiB até 256KiB
    tests = ["4 16", "8 16", "16 16", "32 16", 
             "64, 16", "128 16", "256 16", "1024 16"]
    
    if benchmark == "gcc":
        for test in tests:
            commandline = "./run.sh gcc 16 " + test
            system(commandline)
        return

    if benchmark == "go":
        for test in tests:
            commandline = "./run.sh go 16 " + test
            system(commandline)
        return

if __name__ == "__main__":
    fully_associative("gcc")
    fully_associative("go")
