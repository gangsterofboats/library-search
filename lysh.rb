#!/usr/bin/env ruby

require 'roo'

search = ARGV.join(' ')
file = File.expand_path('~/Documents/Library.xlsx')
libx = Roo::Spreadsheet.open(file)
lib = libx.sheet(libx.default_sheet).to_csv
lib = lib.split("\n")
lib.each do |line|
  puts line if line.include? search
end
