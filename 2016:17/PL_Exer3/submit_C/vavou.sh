#! /bin/bash

clear
gcc -std=c99 -Wall -Werror -O3 -o a.out  myDominos.c
time bash run.sh
