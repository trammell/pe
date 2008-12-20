#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Sieve max => 1000;

my @p = Sieve->primes();

my $prod = 1;
for my $i (0 .. $#p) {
    last if $prod * $p[$i] > 1_000_000;
    $prod *= $p[$i];
}

print $prod;

__END__

Euler's Totient function, phi(n) [sometimes called the Phi function] is
used to determine the number of numbers less than n which are relatively
prime to n.  For example, as 1, 2, 4, 5, 7 and 8 are all less than 9 and
relatively prime to 9, phi(9) = 6.

    n   relatively prime    phi(n)  n/phi(n)
    2   1                   1       2
    3   1,2                 2       1.5
    4   1,3                 2       2
    5   1,2,3,4             4       1.25
    6   1,5                 2       3
    7   1,2,3,4,5,6         6       1.16...
    8   1,3,5,7             4       2
    9   1,2,4,5,7,8         6       1.5
    10  1,3,7,9             4       2.5

It can be seen that n=6 produces a maximum n/phi(n) for n <= 10.

Find the value of n <= 1,000,000 for which n/phi(n) is a maximum.

Analysis:

6 is a local maximum because it's relatively prime only to 5 (everything is
RP to 1).  So if we multiply 2, 3, 5, 7, 11, ... up to some number less
than 1_000_000, we should have our local maximum, which turns out to be
the number 510510.  Exactly what phi(n) is is not part of the answer.

