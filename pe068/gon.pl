#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use List::Util 'sum';
use List::MoreUtils 'all';

print is_magic([4,6,5,3,2,1]);
print is_magic([4,6,5,3,1,2]);

sub is_magic {
    my $gon = shift;
    my $n = scalar(@$gon) / 2;
    my @sum;
    for my $i (0 .. $n - 1) {
        my @j = ($i, $n + ($i % $n), $n + (($i + 1) % $n));
        $sum[$i] = sum map { $gon->[$_] } @j;
    }
    my $s = shift @sum;
    return all { $s == $_ } @sum;
}

1;

