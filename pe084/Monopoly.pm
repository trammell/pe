#!/usr/bin/perl -l

package Monopoly;
use strict;
use warnings FATAL => 'all';
use Data::Dumper;

unless (caller()) {
    for (1 .. 1000) {
        my $t6 = throw(6);
        die "bad throw: $t6" if $t6 < 2 || $t6 > 12;
        my $t4 = throw(4);
        die "bad throw: $t4" if $t4 < 2 || $t4 > 8;
    }
}

sub spaces {
    return qw(
        GO A1 CC1 A2 T1 R1 B1 CH1 B2 B3
        JAIL C1 U1 C2 C3 R2 D1 CC2 D2 D3
        FP E1 CH2 E2 E3 R3 F1 F2 U2 F3
        G2J G1 G2 CC3 G3 R4 CH3 H1 T2 H2
    );
}

sub throw {
    my $n = shift;
    my $d1 = 1 + int(rand($n));
    my $d2 = 1 + int(rand($n));
    return $d1 + $d2;
}

