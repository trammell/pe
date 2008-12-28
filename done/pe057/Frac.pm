#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Math::BigInt;

my $one = Math::BigInt->new(1);
my $two = Math::BigInt->new(2);
my $three = Math::BigInt->new(3);

my @n = ($one,$three);
my @d = ($one,$two);

my $count = 0;

for my $i (2 .. 1000) {
    $n[$i] = 2 * $n[$i-1] + $n[$i-2];
    $d[$i] = 2 * $d[$i-1] + $d[$i-2];
    next if length($n[$i]) <= length($d[$i]);
    print "$i => $n[$i] / $d[$i]";
    $count++;
}

print $count;


__END__

http://projecteuler.net/index.php?section=problems&id=57

Problem 57
21 November 2003

It is possible to show that the square root of two can be expressed as an
infinite continued fraction.

    sqrt(2) = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...

By expanding this for the first four iterations, we get:

    1 + 1/2 = 3/2 = 1.5
    1 + 1/(2 + 1/2) = 7/5 = 1.4
    1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
    1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...

The next three expansions are 99/70, 239/169, and 577/408, but the eighth
expansion, 1393/985, is the first example where the number of digits in the
numerator exceeds the number of digits in the denominator.

In the first one-thousand expansions, how many fractions contain a
numerator with more digits than denominator?

