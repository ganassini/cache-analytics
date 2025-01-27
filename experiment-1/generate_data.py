#!/usr/bin/python

from os import system


def generate_s(i,j,benchmark):
    commandline = "./run.sh " + benchmark + " s " + str(2**i) + " " + str(2**j)
    system(commandline)
    return


def generate_u(i,j,benchmark):
    commandline = "./run.sh " + benchmark + " u " + str(2**i) + " " + str(2**j)
    system(commandline)
    return


if __name__ == "__main__":
    """i,j = 3,3
    while True:
        generate_s(i,j,"gcc")
        i += 1
        generate_u(i,j,"gcc")
        if i == 8:
            break
        generate_s(i,j,"gcc")
        j += 1
        generate_u(i,j, "gcc")"""

    i,j = 3,3
    while True:
        generate_s(i,j,"go")
        i += 1
        generate_u(i,j,"go")
        if i == 8:
            break
        generate_s(i,j,"go")
        j += 1
        generate_u(i,j, "go")
