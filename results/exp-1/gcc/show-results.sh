#!/bin/sh

SEP_1="====================="
SEP_2="--------------------------------------------------"

for file in *.txt; do echo $file; echo $SEP_1; cat $file; echo $SEP_2; done
