#!/usr/bin/env ruby

require 'sqlite3'

search = ARGV.join(' ')
dbname = File.expand_path('~/Documents/Library.sqlite')
db = SQLite3::Database.open dbname

tables = db.execute("SELECT name FROM sqlite_master WHERE type='table'")
tables.flatten!
if tables.include? 'table_search'
  db.execute('DROP TABLE table_search')
end
db.execute('CREATE VIRTUAL TABLE table_search USING FTS5(Author,Editor,Translator,Title,Category,"ISBN-10","ISBN-13","DDC Number","LCC Number")')
db.execute('INSERT INTO table_search SELECT * FROM Sheet1')
results = db.execute('SELECT * FROM table_search WHERE table_search MATCH ?', search)
puts results
