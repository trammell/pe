#!/usr/bin/perl
# vim: set ai et ts=4 tw=75 :

package Sieve;

use strict;
use warnings FATAL => 'all';

our $POS;
our $MAX;
our $VEC;
our @PRIMES;    # list of known primes
our %LOOKUP;    # fast prime lookup

unless (caller()) {
    Sieve->import(max => 10_000);
    my @p = Sieve->primes;
    print "@p[0..9]\n";
}

sub import {
    my ($class, %args) = @_;
    $MAX = $args{max} || 1_000_000;
    $POS = 1;
    $VEC = q();
    vec($VEC,0,1) = 1;    # zero is not prime
    vec($VEC,1,1) = 1;    # one is not prime
    build_sieve();
}

sub build_sieve {
    local $| = 1;
    local $\ = q();
    print "Building sieve: ";
    while (max_prime() < $MAX) {
        print "." unless nprimes() % 2000;
        Sieve->sieve();
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
    return $LOOKUP{$n};
}

sub sieve {
    # walk the sieve to the next unmarked position
    while (1) {
        $POS++;
        last unless vec($VEC,$POS,1);
    }

    my $prime = $POS;
    push @PRIMES, $prime;
    $LOOKUP{$prime} = 1;

    # flag all multiples of $prime in the sieve
    # NOTE: we can start at $prime * $prime, since all smaller multiples
    # (2*$prime, 3*$prime, etc.) have been flagged as composite already.
    for (my $i = $prime * $prime; $i <= $MAX; $i += $prime) {
        vec($VEC,$i,1) = 1;
    }
}

1;

