#!/usr/bin/perl -l
# vim: set ai et ts=4 :

use strict;
use warnings;
use List::Util 'sum';

# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
#
# Find the sum of all numbers which are equal to the sum of the factorial of
# their digits.
#
# Note: as 1! = 1 and 2! = 2 are not sums they are not included.

my %fac = (
    0 => 1,
    1 => 1,
    2 => 2,
    3 => 6,
    4 => 24,
    5 => 120,
    6 => 720,
    7 => 5040,
    8 => 40320,
    9 => 362880,
);

my $sum = 0;
for (3 .. 1_000_000) {
    print "$_..." if $_ % 10000 == 0;
    next unless is_curious($_);
    print "=> $_";
    $sum += $_;
}

print "sum = $sum";

sub is_curious {
    my $n = shift;
    return $n == sumfac($n);
}

sub sumfac {
    my $sum = 0;
    for (split(//, $_[0])) {
        $sum += $fac{$_};
    }
    return $sum;
}

