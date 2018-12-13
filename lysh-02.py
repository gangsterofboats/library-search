#!/usr/bin/env python

import itertools
import os
import sqlite3
import sys

search = ' '.join(sys.argv[1:])
db = sqlite3.connect(os.path.expanduser('~/Documents/Library.sqlite'))
c = db.cursor()
tables = db.execute("SELECT name FROM sqlite_master WHERE type='table'")
c.execute("SELECT name FROM sqlite_master WHERE type='table'")
tables = c.fetchall()
tables = list(itertools.chain(*tables))
if 'table_search' in tables:
    c.execute('DROP TABLE table_search')
c.execute('CREATE VIRTUAL TABLE table_search USING FTS5(Author,Editor,Translator,Title,Category,"ISBN-10","ISBN-13","DDC Number","LCC Number")')
c.execute('INSERT INTO table_search SELECT * FROM Sheet1')
c.execute('SELECT * FROM table_search WHERE table_search MATCH ?', [search])
print(c.fetchall())

db.close()
