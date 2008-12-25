#!/usr/bin/perl
# vim: set ai et ts=4 tw=75 :

package Sieve;

use strict;
use warnings FATAL => 'all';

my $MAX;
my @PRIMES;     # ordered list of known primes
my %PRIMES;     # for fast lookup of primes

unless (caller()) {
    Sieve->import;
    my @p = Sieve->primes;
    print "@p[0..9]\n";
}

sub import {
    my ($class, %args) = @_;
    $MAX = $args{max} || 1_000_000;
    build_sieve();
}

sub build_sieve {
    local $| = 1;
    local $\ = q();
    my $sqrt = int(sqrt(1 + $MAX));
    my $incr = int($MAX / 50);
    my $v    = q();

    print "Building sieve";

    for my $i (2 .. $MAX) {
        print "." if $i % $incr == 0;

        # if vec($v,$i,1) is 0, then $i is prime.

        if (vec($v,$i,1) == 0) {
            push @PRIMES, $i;
            $PRIMES{$i} = 1;

            # Since $i is prime, all multiples of $i in the sieve can be
            # flagged as composite.  We start at $i*$i, since all smaller
            # multiples (2*$i, 3*$i, 4*$i, etc.) have already been flagged as
            # composite.  This also means that we don't need to sieve out
            # multiples of $i unless $i*$i is less than $MAX.

            next unless $i < $sqrt;

            for (my $j = $i * $i; $j <= $MAX; $j += $i) {
                vec($v,$j,1) = 1;
            }
        }
    }

    print "\n";
}

sub max_prime {
    return $PRIMES[-1] || 0;
}

sub nprimes {
    return scalar(@PRIMES);
}

sub primes {
    return @PRIMES;
}

sub is_prime {
    my ($class, $n) = @_;
    die "Value '$n' is out of range" if $n > $MAX;
    return $PRIMES{$n};
}

1;

