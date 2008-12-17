#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use Math::Prime::XS 'is_prime';

unless (caller()) {
    my $best = [0, undef, undef ];
    for my $a (1 .. 999) {
        print "a=$a ... best=@$best" if $a % 10 == 0;
        for my $b (1 .. 999) {
            # n=0 yields b, so b must be prime
            next unless is_prime($b);
            for ([$a,$b],[-$a,$b],[$a,-$b],[-$a,-$b]) {
                my $pc = pcount(@$_);
                next unless $pc > $best->[0];
                print "new best: a=$_->[0] b=$_->[1] pc=$pc";
                $best = [$pc, @$_];
            }
        }
    }
    print "@$best"
}

sub pcount {
    my ($a,$b) = @_;
    my $i = 0;
    while (1) {
        my $x = ($i + $a) * $i + $b;
        last if $x < 2;
        last unless is_prime($x);
        $i++;
    }
    return $i;
}


1;

__END__

Euler published the remarkable quadratic formula:

    n^2 + n + 41

It turns out that the formula will produce 40 primes for the consecutive values
n = 0 to 39. However, when n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41 is
divisible by 41, and certainly when n = 41, 41^2 + 41 + 41 is clearly divisible
by 41.

Using computers, the incredible formula  n^2 - 79n + 1601 was discovered, which
produces 80 primes for the consecutive values n = 0 to 79. The product of the
coefficients, -79 and 1601, is -126479.

Considering quadratics of the form:

    n^2 + an + b, where |a| < 1000 and |b| < 1000

(where |n| is the modulus/absolute value of n, e.g. |11| = 11 and |4| = 4)

Find the product of the coefficients, a and b, for the quadratic expression
that produces the maximum number of primes for consecutive values of n,
starting with n = 0.


