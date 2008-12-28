#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;

my @close = (0,0,0);

for (my $den = 999_999; $den > 0; $den--) {
    print "$den..." if $den % 1000 == 0;
    next if $den % 7 == 0;
    my $num = int( 3 * $den / 7 );
    my $float = $num / $den;
    next if $float < $close[0];
    @close = ($float, $num, $den);
}

print "@close";

__END__

http://projecteuler.net/index.php?section=problems&id=71

Problem 71
04 June 2004

Consider the fraction, n/d, where n and d are positive integers. If n<d and
HCF(n,d)=1, it is called a reduced proper fraction.

If we list the set of reduced proper fractions for d<=8 in ascending order
of size, we get:

    1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8,
    2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

It can be seen that 2/5 is the fraction immediately to the left of 3/7.

By listing the set of reduced proper fractions for d<=1,000,000 in
ascending order of size, find the numerator of the fraction immediately to
the left of 3/7.

NOTE: HCF(a,b) === GCD(a,b) (greatest common denominator)

Analysis:

    0/1, 1/0

d(2) = 1/2

d(3) = 1/3, 1/2, 2/3

d(4) = 1/4, 1/3, 1/2, 2/3, 3/4

    1/4, 2/4, 3/4
    1/3, 2/3
    1/2

d(5) = 

    1/5, 2/5, 3/5, 4/5 
    1/4, 1/2, 3/4
    1/3, 2/3


2/5 = 4/10 = 400_000 / 1_000_000

    x / i = 3 / 7
    x = 3i/7
