#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use List::Util 'sum';

unless (caller()) {
    my @names = @{ load() };
    print sum map { ($_ + 1) * letter_score($names[$_]) } 0 .. $#names;
}


sub load {
    my $names = do { local(@ARGV,$/) = ("names.txt"); <> };
    my @names = map { s/\s//g; $_ } map { s/"//g; $_ } split(/,/,$names);
    return [ sort @names ];
}

sub letter_score {
    return sum map { ord($_) - ord('A') + 1 } split //, $_[0];
}


__END__

Using names.txt (right click and 'Save Link/Target As...'), a 46K text file
containing over five-thousand first names, begin by sorting it into
alphabetical order. Then working out the alphabetical value for each name,
multiply this value by its alphabetical position in the list to obtain a name
score.

For example, when the list is sorted into alphabetical order, COLIN, which is
worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would
obtain a score of 938 x 53 = 49714.

What is the total of all the name scores in the file?


