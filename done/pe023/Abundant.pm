#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

package Abundant;

use strict;
use warnings;
local $| = 1;

warn "initializing\n";
my @ab;
for (1 .. 28123) {
    printf "." if $_ % 281 == 0;
    $ab[$_] = ab($_);
}
warn "done initializing\n";

unless (caller()) {
    my $sum = 0;
    CANDIDATE:
    for my $i (1 .. 28123) {
        print "$i (sum=$sum) ..." if $i % 100 == 0;
        next if is_composite($i);
        $sum += $i;
    } 
    print "sum=$sum";
}

sub is_composite {
    my $n = shift;
    for my $j (1 .. $n - 1) {
        return 1 if $ab[$j] && $ab[$n - $j];
    }
    return 0;
}

sub ab {
    my $n = shift;
    my $sum = 0;
    for (1 .. $n - 1) {
        next unless $n % $_ == 0;
        $sum += $_;
    }
    return 1 if $sum > $n;
    return 0;
}

__END__

A perfect number is a number for which the sum of its proper divisors is
exactly equal to the number. For example, the sum of the proper divisors of
28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
number.

A number whose proper divisors are less than the number is called deficient
and a number whose proper divisors exceed the number is called abundant.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
number that can be written as the sum of two abundant numbers is 24. By
mathematical analysis, it can be shown that all integers greater than 28123
can be written as the sum of two abundant numbers. However, this upper
limit cannot be reduced any further by analysis even though it is known
that the greatest number that cannot be expressed as the sum of two
abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the
sum of two abundant numbers.

