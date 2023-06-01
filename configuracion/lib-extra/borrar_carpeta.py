#!/usr/bin/python3
# -*- coding:utf-8 -*-

from sys import argv
from shutil import rmtree
from os.path import isdir

def main(carpetas):
    for c in carpetas:
        if isdir(c):
            rmtree(c)

if __name__ == '__main__':
    main(argv[1:])
