#!/usr/bin/env perl

use strict;
use warnings;
use lib '../lib';
use Sieve;

my @PRIMES = Sieve->primes;

for my $i (0 .. 10) {
    my $n = $i + 1;
    my $p = $PRIMES[$i];
    my $x = ($p - 1) ** $n + ($p + 1) ** $n;
    my $r = $x % ($p * $p);
    print "n=$n p=$p r=$r\n";
}


__END__

Problem 123
16 June 2006
http://projecteuler.net/index.php?section=problems&id=123

Let p[n] be the nth prime: 2, 3, 5, 7, 11, ..., and let r be the remainder
when (p[n]-1)^n + (p[n]+1)^n is divided by p[n]^(2).

For example, when n=3, p[3]=5, and 4^3 + 6^3 = 280 = 5 mod 25.

The least value of n for which the remainder first exceeds 10^9 is 7037.

Find the least value of n for which the remainder first exceeds 10^10.

Analysis:

    (p+1)^n = p^n + C(n,1)p^(n-1) + C(n,2)p^(n-2) + ... + C(n,n-1)p + 1

    (p-1)^n = p^n - C(n,1)p^(n-1) + C(n,2)p^(n-2) + ... + C(n,n-1)(-1)^(n-1)p + (-1)^n

Adding the two yields:

    2 * p^n + 2 * C(n,2)p^(n-2) + 2 * C(n,4)p^(n-4) + ...




