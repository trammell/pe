#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;

unless (caller()) {
    my $n;
    my %s = map { $_ => 1 } (1,10,100,1000,10_000,100_000,1_000_000);
    my $p = 1;
    for my $i (1 .. 250000) {
        for (split //, $i) {
            $n++;
            if ($s{$n}) {
                $p *= $_;
                print " ${n}th digit is $_ => p=$p";
            }
        }
        last if $n > 1_000_000;
    }

}

1;

__END__

http://projecteuler.net/index.php?section=problems&id=40

An irrational decimal fraction is created by concatenating the positive
integers:

    0.123456789101112131415161718192021...

It can be seen that the 12th digit of the fractional part is 1.

If d[n] represents the "n"th digit of the fractional part, find the value of
the following expression.

    d[1] x d[10] x d[100] x d[1000] x d[10000] x d[100000] x d[1000000]



