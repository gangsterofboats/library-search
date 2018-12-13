#!/usr/bin/env perl6

my $search =  @*ARGS.join(' ');
my $file = '/home/michael/Documents/Library.xlsx';
my $lib = qq:x[ssconvert --export-type=Gnumeric_stf:stf_csv $file fd://1];
for lines($lib)
{
    say $_ if $_ ~~ /$search/;
}
