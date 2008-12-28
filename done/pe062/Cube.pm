#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Data::Dumper;
use Math::BigInt;
use List::Util 'min';

my %x;
for my $i (1 .. 10_000) {
    print "i=$i" if $i % 100 == 0;
    my $j = Math::BigInt->new("$i");
    my $k = $j * $j * $j;
    push @{ $x{ canon($k->bstr) } }, $i;
}

while (my ($k,$v) = each %x) {
    next if scalar @$v < 4;
    my $m = Math::BigInt->new(min(@$v));
    my $n = $m * $m * $m;
    print "$k => @$v => $n";
}

sub canon {
    return join q(), sort split //, $_[0];
}

__END__

http://projecteuler.net/index.php?section=problems&id=62

Problem 62
30 January 2004

The cube, 41063625 (345^3), can be permuted to produce two other cubes:
56623104 (384^3) and 66430125 (405^3). In fact, 41063625 is the smallest
cube which has exactly three permutations of its digits which are also
cube.

Find the smallest cube for which exactly five permutations of its digits
are cube.

