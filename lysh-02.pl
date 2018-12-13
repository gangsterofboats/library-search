#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use DBI;
use feature 'say';

my $search = join(' ', @ARGV);
my $dbh = DBI->connect('DBI:SQLite:dbname=/home/michael/Documents/Library.sqlite');
my @tables = map {@$_} @{$dbh->selectall_arrayref("SELECT name FROM sqlite_master WHERE type='table'")};
if (grep('table_search', @tables))
{
    $dbh->do('DROP TABLE table_search');
}
$dbh->do('CREATE VIRTUAL TABLE table_search USING FTS5(Author,Editor,Translator,Title,Category,"ISBN-10","ISBN-13","DDC Number","LCC Number")');
my $sth = $dbh->prepare('INSERT INTO table_search SELECT * FROM Sheet1');
$sth->execute();
$sth = $dbh->prepare('SELECT * FROM table_search WHERE table_search MATCH ?');
$sth->execute($search);
my @results = @{$sth->fetchall_arrayref()};
say Dumper @results;
