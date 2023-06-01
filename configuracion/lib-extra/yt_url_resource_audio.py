#!/usr/bin/python3
# -*- coding:utf-8 -*-

# Otros id de formatos posibles para audio:
# 249 250 251 140

from sys import argv
from youtube_dl import YoutubeDL

def main(url, fid='140'):
    ydl_opts = {
        'quiet': True,
        'verbose': False,
        'dump-json': True,
    }
    with YoutubeDL(ydl_opts) as ydl:
        dat = ydl.extract_info(url, download=False)

        for e in dat['formats']:
            if e['format_id'] == fid:
                print(e['url'])

if __name__ == '__main__':
    main(argv[1])
