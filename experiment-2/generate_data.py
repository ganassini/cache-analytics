#!/usr/bin/python
# 
# testes de 4KiB até 64KiB

from os import system


def direct_mapping(benchmark):
    #tests = ["256 1", "512 1", "1024 1", "2048 1", "4096 1"]
    tests = ["32 1", "65536  1"]

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


def eight_way(benchmark):
    #tests = ["32 8", "64 8", "128 8", "256 8", "512 8"]
    tests = ["4 8", "8192 8"]

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
    #tests = ["16 16", "32 16", "64 16", "128 16", "256 16"]
    tests = ["2 16", "4096 16"]

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


def fully_associative(benchmark):
    #tests = ["1 256", "1 512", "1 1024", "1 2048", "1 4096"]
    tests = ["1 32", "1 65536"]

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


if __name__ == "__main__":
    direct_mapping("gcc")
    direct_mapping("go")
    eight_way("gcc")
    eight_way("go")
    sixteen_way("gcc")
    sixteen_way("go")
    fully_associative("gcc")
    fully_associative("go")
