#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;

my $count = 0;

for my $d (1 .. 10_000) {
    print "$d... " if $d % 500 == 0;
    for (my $n = 1 + int($d / 3); 2 * $n < $d; $n++) {
        next unless GCD($d,$n) == 1;
        $count++;
    }
}

print $count;

sub GCD {
    my ($a, $b) = @_;
    return $a unless $b;
    return GCD($b, $a % $b);
}

__END__

http://projecteuler.net/index.php?section=problems&id=73

Problem 73
02 July 2004

Consider the fraction, n/d, where n and d are positive integers. If n < d
and HCF(n,d)=1, it is called a reduced proper fraction.

If we list the set of reduced proper fractions for d <= 8 in ascending
order of size, we get:

    1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2,
    4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

It can be seen that there are 3 fractions between 1/3 and 1/2.

How many fractions lie between 1/3 and 1/2 in the sorted set of reduced
proper fractions for d <= 10,000?

