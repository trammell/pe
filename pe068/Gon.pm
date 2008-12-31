#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use base 'Exporter';
use List::MoreUtils 'all';

our @EXPORT = qw( is_magic );

sub is_magic {
    my @outer = @{ $_[0] };
    my @inner = @{ $_[1] };
    my $n = @outer;
    my @sum;
    for my $i (0 .. $n - 1) {
        $sum[$i] = $outer[$i] + $inner[$i] + $inner[ ($i + 1) % $n ];
    }
    my $s = shift @sum;
    return (all { $s == $_ } @sum) ? 1 : 0;
}

1;

