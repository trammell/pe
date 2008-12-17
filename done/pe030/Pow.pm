#!/usr/bin/perl -l

use strict;
use warnings;
use List::Util 'sum';

my %POW = map { $_ => $_ ** 5 } 0 .. 9;

unless (caller()) {
    my $i = 10;
    my $sum = 0;
    while (1) {
        print "# $i (sum=$sum)..." if $i++ % 10_000 == 0;
        next unless x($i) == $i;
        $sum += $i;
        print "$i => sum=$sum";
    }
}

sub x {
    my $n = shift;
    return sum map $POW{$_}, split //, $n;
}

1;

__END__

Surprisingly there are only three numbers that can be written as the sum of
fourth powers of their digits:

    1634 = 1^4 + 6^4 + 3^4 + 4^4
    8208 = 8^4 + 2^4 + 0^4 + 8^4
    9474 = 9^4 + 4^4 + 7^4 + 4^4

As 1 = 1^4 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers
of their digits.

