#!/usr/bin/env perl

package Sieve;
use strict;
use warnings FATAL => 'all';
use Time::HiRes;

our $VERBOSE;           # verbosity switch
my  $MAX = 200_000;     # largest possible prime found
my  @PRIMES;            # ordered list of known primes

sub import {
    my ($class, %args) = @_;
    $MAX ||= $args{max};
    build();
}

sub max {
    my $class = shift;
    $MAX ||= 100;
    if (@_) { $MAX = $_[0]; }
    return $MAX;
}

sub nprimes {
    return scalar(@PRIMES);
}

sub primes {
    return @PRIMES;
}

sub build {
    my $class = shift;
    my $s    = q(); # the sieve

    my $sqrt = int(sqrt(1 + $MAX));
    my $incr = int($MAX / 50);

    print STDERR "Building sieve: ." if $VERBOSE;
    my $t0 = [ Time::HiRes::gettimeofday() ];

    for my $i (2 .. $MAX) {
        print STDERR "." if $VERBOSE && $i % $incr == 0;

        # if vec($v,$i,1) is 0, then $i is prime.
        if (vec($s,$i,1) == 0) {
            push @PRIMES, $i;

            # Since $i is prime, all multiples of $i are composite, and can be
            # flagged as such in the sieve.  We start at $i*$i, since all
            # smaller multiples (2*$i, 3*$i, 4*$i, etc.) have already been
            # flagged as composite.  This also means that we only need to
            # sieve out multiples of $i if $i*$i is less than $MAX.

            for (my $j = $i * $i; $j <= $MAX; $j += $i) {
                vec($s,$j,1) = 1;
            }
        }
    }

    print STDERR "\n" if $VERBOSE;

    my $np = scalar @PRIMES;
    my $elapsed = Time::HiRes::tv_interval($t0);
    warn "Sieved $np primes from 2 .. $PRIMES[-1] in (${elapsed}s).\n";
}

1;

