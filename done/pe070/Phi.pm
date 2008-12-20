#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Totient;

my @best = (0,0,1e100);

for my $n (9_000_000 .. 10_000_000) {
    print "n=$n" if $n % 100_000 == 0;
    my $phi = phi($n);
    next unless length($phi) == length($n);

    my $x1 = join q(), sort split //, $n;
    my $x2 = join q(), sort split //, $phi;

    next unless $x1 eq $x2;
    my $f = $n / $phi;
    if ($f < $best[2]) {
        print "phi($n)=$phi f=$f";
        @best = ($n, $phi, $f);
    }
}

print "@best";

__END__

http://projecteuler.net/index.php?section=problems&id=70

Problem 70
21 May 2004

Euler's Totient function, Phi(n) [sometimes called the phi function], is
used to determine the number of positive numbers less than or equal to n
which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are
all less than nine and relatively prime to nine, Phi(9)=6.

The number 1 is considered to be relatively prime to every positive number,
so Phi(1)=1.

Interestingly, Phi(87109)=79180, and it can be seen that 87109 is a
permutation of 79180.

Find the value of n, 1 < n < 10^(7), for which Phi(n) is a permutation of n
and the ratio n/Phi(n) produces a minimum.

