#!/usr/bin/env python

import os
import pandas
import sys

search = ' '.join(sys.argv[1:])
libx = pandas.read_excel(os.path.expanduser('~/Documents/Library.xlsx'))
lib = libx.to_csv(index=False)
lib = lib.split('\n')
for line in lib:
    if search in line:
        print(line)
