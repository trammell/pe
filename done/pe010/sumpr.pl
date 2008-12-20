#!/usr/bin/perl -l
# vim: set ai et ts=4 :

use strict;
use warnings;
use List::Util 'sum';
use Data::Dumper;

my @PRIMES = (2,3,5,7,11,13,17);

# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.

my $max = $ARGV[0] || 2_000_000;
my $sum = 0;
foreach my $n (2 .. $max) {
    next unless is_prime($n);
    print "prime: $n";
    $sum += $n;
}

print $sum;

sub grow_primes {
    my $cand = maxprime() + 2;
    while (1) {
        last if is_prime($cand);
        $cand += 2;
    }
    push @PRIMES, $cand;
}

sub maxprime {
    return $PRIMES[-1];
}

sub is_prime {
    my $n = shift;
    while (1) {
        last if maxprime() * maxprime() >= $n;
        grow_primes();
    }
    foreach my $p (@PRIMES) {
        last if $p * $p > $n;
        return 0 if $n % $p == 0;
    }
    return 1;
}

