#!/usr/bin/python3
# -*- coding:utf-8 -*-

from sys import argv
from os import unlink
from glob import glob
from os.path import exists, isfile, realpath


def main(ruta, filtro):
    ruta = realpath(ruta)
    pattern = f'{ruta}/**/{filtro}'

    arcs = glob(pattern, recursive=True)
    for ar in arcs:
        if isfile(ar):
            unlink(ar)


if __name__ == '__main__':
    ruta_raiz = argv[1]
    filtro = argv[2]
    main(ruta_raiz, filtro)
