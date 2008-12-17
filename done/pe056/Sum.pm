#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use Math::BigInt;
use List::Util 'sum';

unless (caller()) {
    my $max = 0;
    for my $a (90 .. 99) {
        print "$a ...";
        for my $b (90 .. $a) {
            my $x = Math::BigInt->new($a)->bpow($b);
            my $sum = sum split //, $x->bstr;
            next unless $sum > $max;
            $max = $sum;
            print "a=$a b=$b sum=$sum";
        }
    }
    print $max;
}

1;

__END__

A googol (10^100) is a massive number: one followed by one-hundred zeros;
100^100 is almost unimaginably large: one followed by two-hundred zeros.
Despite their size, the sum of the digits in each number is only 1.

Considering natural numbers of the form, a^b, where a, b < 100, what is the
maximum digital sum?



