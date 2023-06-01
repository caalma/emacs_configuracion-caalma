#!/usr/bin/python3
# -*- coding:utf-8 -*-

from sys import argv
from os import unlink
from os.path import isfile

def main(archivos):
    for a in archivos:
        if isfile(a):
            unlink(a)

if __name__ == '__main__':
    main(argv[1:])
