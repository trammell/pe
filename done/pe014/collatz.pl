#!/usr/bin/perl
# vim: set ai et ts=4 :
use strict;
use warnings;

# http://projecteuler.net/index.php?section=problems&id=14
#
# The following iterative sequence is defined for the set of positive integers:
#
#     n => n/2 (n is even)
#     n => 3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following
# sequence:
#
#     13 40 20 10 5 16 8 4 2 1
#
# It can be seen that this sequence (starting at 13 and finishing at 1)
# contains 10 terms. Although it has not been proved yet (Collatz Problem), it
# is thought that all starting numbers finish at 1.
#
# Which starting number, under one million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.


my @CLEN = (-1);
my ($max, $imax) = (0,0);

for (1 .. 1_000_000) {
    print "$_...\n" if $_ % 1000 == 0;
    $CLEN[ $_ ] = clen($_);
    if ($CLEN[$_] > $max) {
        ($max, $imax) = ($CLEN[$_], $_);
    }
}

print "$imax => $max\n";

sub collatz {
    my $n = shift;
    return ($n & 1) ? 3 * $n + 1 : $n / 2;
}

sub clen {
    my $n = shift;
    my $len = 0;
    while (1) {
        if ($CLEN[$n]) {
            return $len + $CLEN[$n];
        }
        $len++;
        if ($n == 1) {
            return $len;
        }
        # inline iteration is faster...
        $n = ($n & 1) ? 3 * $n + 1 : $n / 2;
#       $n = collatz($n);

    }
    return $len;
}

