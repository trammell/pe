#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

local $| = 1;

use strict;
use warnings;
use Sieve;

my @primes = Sieve->primes;
pop(@primes) while @primes > 10_000;
print "@primes[0 .. 20]";
print "@primes[-10..-1]";

my $s = 1;      # length of side
my $n = 1;      # number of values tested
my $p = 0;      # number of primes found
my $pct;

while (1) {
    $s += 2;
    $n += 4;
    foreach my $c (corners($s)) {
        $p++ if is_prime($c);
    }
    $pct = 100.0 * $p / $n;
    print "s=$s n=$n p=$p %=$pct" if $s % 100 == 1;
    last if $pct < 10.0;
}

print "final: s=$s n=$n p=$p pct=$pct";

sub corners {
    my $n = shift;
    # $n * $n,      # just skip this corner...
    return (
        $n * $n - $n + 1,
        $n * $n - 2 * $n + 2,
        $n * $n - 3 * $n + 3,
    );
}

sub is_prime {
    my $n = shift;
    if ($n < Sieve->max_prime) {
        return Sieve->is_prime($n);
    }
    if ($primes[-1] * $primes[-1] > $n) {
        for my $prime (@primes) {
            return 0 if $n % $prime == 0;
        }
        return 1;
    }
    return is_fermat_prime($n,30);
}

sub is_fermat_prime {
    my $p = shift;
    my $tests = shift;
    my $ok = 0;
    for (1 .. $tests) {
        my $a = 5 + int(rand(0.9 * $p));
        $ok++ if modexp($a, $p - 1, $p) == 1;
    }
    return $ok == $tests ? 1 : 0;
}

sub modexp {
    my ($a,$n,$m) = @_;
    my $r = 1;
    while ($n) {
        if ($n % 2 == 1) {
            $r = ($r * $a) % $m;
            $n--;
        }
        else {
            $n /= 2;
            $a = ($a * $a) % $m;
        }
    }
    return $r;
}

__END__

http://projecteuler.net/index.php?section=problems&id=58

Problem 58
05 December 2003

Starting with 1 and spiralling anticlockwise in the following way, a square
spiral with side length 7 is formed.

        37 36 35 34 33 32 31
        38 17 16 15 14 13 30
        39 18  5  4  3 12 29
        40 19  6  1  2 11 28
        41 20  7  8  9 10 27
        42 21 22 23 24 25 26
        43 44 45 46 47 48 49

It is interesting to note that the odd squares lie along the bottom right
diagonal, but what is more interesting is that 8 out of the 13 numbers
lying along both diagonals are prime; that is, a ratio of 8/13 ~ 62%.

If one complete new layer is wrapped around the spiral above, a square
spiral with side length 9 will be formed. If this process is continued,
what is the side length of the square spiral for which the ratio of primes
along both diagonals first falls below 10%?

Analysis:

See the PE028 forum for details.

