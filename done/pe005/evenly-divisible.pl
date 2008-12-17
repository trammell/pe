#!/usr/bin/perl

use strict;
use warnings;
#use bigint;

# 2520 is the smallest number that can be divided by each of the numbers from 1
# to 10 without any remainder. What is the smallest number that is evenly
# divisible by all of the numbers from 1 to 20?

my $max = $ARGV[0] || 20;

for (1 .. $max) {
    printf "%2d => %d\n", $_, leastmult($_);
}

sub leastmult {
    my $n = shift;
    my $acc = 1;

    for (1 .. $n) {
        if ($acc % $_) {
            $acc *= $_ / gcd($acc,$_);
        }
    }
    return $acc;
}

sub gcd {
    my ($a,$b) = @_;
    return ($b) ? gcd($b, $a % $b) : $a;
}





