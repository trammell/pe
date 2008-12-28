#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Data::Dumper;

unless (caller()) {
    print Dumper(genpt(3,4,5));
}

sub genpt {
    my ($x,$y,$z) = @_;
    
    my @t1 = sort { $a <=> $b } (
        $x - 2 * $y + 2 * $z,
        2 * $x - $y + 2 * $z,
        2 * $x - 2 * $y + 3 * $z
    );

    my @t2 = sort { $a <=> $b } (
        $x + 2 * $y + 2 * $z,
        2 * $x + $y + 2 * $z,
        2 * $x + 2 * $y + 3 * $z,
    );

    my @t3 = sort { $a <=> $b } (
        -1 * $x + 2 * $y + 2 * $z,
        -2 * $x + $y + 2 * $z,
        -2 * $x + 2 * $y + 3 * $z,
    );

    return \@t1, \@t2, \@t3;
}

1;

