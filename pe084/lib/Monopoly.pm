#!/usr/bin/env perl

package Monopoly;
use strict;
use warnings FATAL => 'all';
use Data::Dumper;

use constant SPACES => qw/
    GO   A1 CC1 A2  T1 R1 B1  CH1 B2 B3
    JAIL C1 U1  C2  C3 R2 D1  CC2 D2 D3
    FP   E1 CH2 E2  E3 R3 F1  F2  U2 F3
    G2J  G1 G2  CC3 G3 R4 CH3 H1  T2 H2
/;

use constant CCHEST => qw/
    NULL NULL NULL NULL NULL NULL NULL
    NULL NULL NULL NULL NULL NULL NULL
    GO JAIL
/;

use constant CHANCE => qw/
    NULL NULL NULL NULL NULL NULL
    GO JAIL C1 E3 H2
    R1 next-R next-R next-U back-3
/;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub die_size {
    my $self = shift;
    if (@_) { $self->{die_size} = $_[0]; }
    return $self->{die_size};
}

sub throw {
    my $self = shift;
    my @d = map { int(1 + rand($self->{die_size})) } 0, 1;
    return $d[0] + $d[1];
}

1;

