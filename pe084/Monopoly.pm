#!/usr/bin/perl -l

package Monopoly;
use strict;
use warnings FATAL => 'all';
use Data::Dumper;

sub spaces {
    return qw(
        GO A1 CC1 A2 T1 R1 B1 CH1 B2 B3
        JAIL C1 U1 C2 C3 R2 D1 CC2 D2 D3
        FP E1 CH2 E2 E3 R3 F1 F2 U2 F3
        G2J G1 G2 CC3 G3 R4 CH3 H1 T2 H2
    );
}

