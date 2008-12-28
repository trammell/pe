#!/usr/bin/perl -l
# vim: set ai et ts=4 :

package Prime;

use strict;
use warnings;
use base 'Exporter';

our @EXPORT_OK = qw( is_prime iter );
our @PRIMES = (2,3,5,7,11,13);

my %cache;

sub is_prime {
    my $n = shift;
    unless (exists $cache{$n}) {
        $cache{$n} = _is_prime($n);
    }
    return $cache{$n};
}

sub _is_prime {
    my $n = shift;
    return 0 if $n <= 1;
    return 1 if $n == 2 || $n == 3;
    while (max_prime() * max_prime() < $n) {
        grow_primes();
    }
    foreach my $p (primes()) {
        last if $p * $p > $n;
        return 0 if $n % $p == 0;
    }
    return 1;
}

sub iter { 
    my $pos = 0;
    return sub {
        grow_primes($pos + 1);
        return $PRIMES[$pos++]
    }
}

sub primes {
    return @PRIMES;
}

sub max_prime {
    return $PRIMES[-1];
}

sub grow_primes {
    my $min_count = shift() || @PRIMES + 1;
    while (@PRIMES < $min_count) {
        my $cand = max_prime() + 2;
        while (1) {
            last if is_prime($cand);
            $cand += 2;
        }
        push @PRIMES, $cand;
    }
}

1;

