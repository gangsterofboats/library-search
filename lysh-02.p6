#!/usr/bin/env perl6
use DBIish;

my $search =  @*ARGS.join(' ');
my $dbh = DBIish.connect('SQLite', database => '/home/michael/Documents/Library.sqlite');
my $sth = $dbh.prepare("SELECT name FROM sqlite_master WHERE type='table'");
$sth.execute();
my @tables = $sth.allrows();
@tables = @tables.List.flat;
if 'table_search' eq any(@tables)
{
    $dbh.do('DROP TABLE table_search');
}
$dbh.do('CREATE VIRTUAL TABLE table_search USING FTS5(Author,Editor,Translator,Title,Category,"ISBN-10","ISBN-13","DDC Number","LCC Number")');
$dbh.do('INSERT INTO table_search SELECT * FROM Sheet1');
$sth = $dbh.prepare('SELECT * FROM table_search WHERE table_search MATCH ?');
$sth.execute($search);
say $sth.allrows();
