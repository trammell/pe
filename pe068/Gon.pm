#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use base 'Exporter';
use List::MoreUtils 'all';

our @EXPORT = qw( as_string is_magic );

unless (caller()) {
    my @g = ([4,6,5],[3,2,1]);
    print as_string(@g);
}

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

sub as_string {
    my @outer = @{ $_[0] };
    my @inner = @{ $_[1] };
    my $n = @outer;
    my $imin = do {
        my @x =
            sort { $a->[0] <=> $b->[0] }
            map [ $outer[$_], $_ ], 0 .. $#outer;
        $x[0][1];
    };
    my @s;
    for my $i ($imin .. $imin + $n - 1) {
        push @s, $outer[$i % $n];
        push @s, $inner[$i % $n];
        push @s, $inner[($i + 1) % $n];
    }
    return join q( ), @s;
}

1;

