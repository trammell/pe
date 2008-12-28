#!/usr/bin/perl
# vim: set ai et ts=4 tw=75 :

package Sieve;

use strict;
use warnings FATAL => 'all';
use Time::HiRes;

my $MAX;
my @PRIMES;     # ordered list of known primes

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
    local $\ = q();
    my $sqrt = int(sqrt(1 + $MAX));
    my $incr = int($MAX / 50);
    my $v    = q();

    print STDERR "Building sieve: .";
    my $t0 = [ Time::HiRes::gettimeofday() ];

    for my $i (2 .. $MAX) {
        print STDERR "." if $i % $incr == 0;

        # if vec($v,$i,1) is 0, then $i is prime.

        if (vec($v,$i,1) == 0) {
            push @PRIMES, $i;

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

    print STDERR "\n";

    my $np = scalar @PRIMES;
    my $elapsed = Time::HiRes::tv_interval($t0);
    warn "Sieved $np primes in $elapsed seconds.\n";
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

1;

