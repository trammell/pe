#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;

unless (caller()) {


}

1;

__END__

It was proposed by Christian Goldbach that every odd composite number can be
written as the sum of a prime and twice a square.

    9  =  7 + 2 x 1^2
    15 =  7 + 2 x 2^2
    21 =  3 + 2 x 3^2
    25 =  7 + 2 x 3^2
    27 = 19 + 2 x 2^2
    33 = 31 + 2 x 1^2

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime
and twice a square?

