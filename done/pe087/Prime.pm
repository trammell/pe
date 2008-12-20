#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Sieve;

my @primes = Sieve->primes;

my %seen;

I:
for (my $i=0; $primes[$i] < 7072; $i++) {
    print "i=$i" if $i % 100 == 0;
    my $pi = $primes[$i] * $primes[$i];
    J:
    for (my $j=0; $primes[$j] < 368; $j++) {
        my $pj = $primes[$j] * $primes[$j] * $primes[$j];
        K:
        for (my $k=0; $primes[$k] < 86; $k++) {
            my $pk = $primes[$k] * $primes[$k] * $primes[$k] * $primes[$k];
            my $sum = $pi + $pj + $pk;
            last if $sum >= 50_000_000;
            $seen{$sum} = 1;
        }
    }
}

print scalar keys %seen;

__END__

Problem 87
21 January 2005

The smallest number expressible as the sum of a prime square, prime cube,
and prime fourth power is 28. In fact, there are exactly four numbers below
fifty that can be expressed in such a way:

    28 = 2^2 + 2^3 + 2^4
    33 = 3^2 + 2^3 + 2^4
    49 = 5^2 + 2^3 + 2^4
    47 = 2^2 + 3^3 + 2^4

How many numbers below fifty million can be expressed as the sum of a prime
square, prime cube, and prime fourth power?

Analysis:

    50_000_000 ^ 0.5   ~ 7071
    50_000_000 ^ 0.333 ~  367
    50_000_000 ^ 0.25  ~   85

