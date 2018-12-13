#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

my $search = join(' ', @ARGV);
my $file = '/home/michael/Documents/Library.xlsx';
my $lib = `ssconvert --export-type=Gnumeric_stf:stf_csv $file fd://1`;
foreach (split(/\n/, $lib))
{
    say $_ if ($_ =~ m/$search/);
}
