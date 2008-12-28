#!/usr/bin/perl -l
# vim: set ai et ts=4 :

package Prime;

use strict;
use warnings;
use base 'Exporter';

our @EXPORT_OK = qw( is_prime prime_iter );

my @PRIMES = (2,3,5,7,11,13);

sub is_prime {
    my $n = shift;
    return 0 if $n < 2;
    return 1 if $n == 2;
    return 1 if $n == 3;
    while (max_prime() * max_prime() < $n) {
        grow_primes();
    }
    foreach my $p (primes()) {
        last if $p * $p > $n;
        return 0 if $n % $p == 0;
    }
    return 1;
}

sub prime_iter { 
    my $index = 0;
    return sub {
        $index++;
    };
}

sub primes {
    return @PRIMES;
}

sub max_prime {
    return $PRIMES[-1];
}

sub grow_primes {
    my $cand = max_prime() + 2;
    while (1) {
        last if is_prime($cand);
        $cand += 2;
    }
    push @PRIMES, $cand;
}

1;

