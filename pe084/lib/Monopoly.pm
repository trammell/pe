#!/usr/bin/env perl

package Monopoly;

use strict;
use warnings FATAL => 'all';
use base 'Class::Accessor::Fast';
use Data::Dumper;
use List::Util qw/ shuffle /;
use List::MoreUtils qw/ first_index /;
use Readonly;

Monopoly->mk_accessors(qw/ freq position turns /);

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
    my $self = bless { @_ }, $class;
    $self->position(0);
    $self->turns(0);
    $self->freq({});

    $self->{cchest} = do {
        Readonly::Array my @cchest => shuffle(CCHEST);
        \@cchest;
    };

    $self->{chance} = do {
        Readonly::Array my @chance => shuffle(CHANCE);
        \@chance;
    };

    return $self;
}

sub take_turn {
    my $self = shift;
    $self->{turns}++;

    my $doubles = 0;
    ROLL: {
        my @t = $self->throw();
        my $d = ($t[0] == $t[1]) ? 1 : 0;
        $doubles++ if $d;
        if ($doubles == 3) {
            $self->set_position('JAIL');
            last ROLL;
        }

        $self->advance($t[0] + $t[1]);

        # land on "go to jail"
        if ($self->sym_position eq 'G2J') {
            $self->set_position('JAIL');
            last ROLL;
        }

        # land on "community chest"
        if ($self->sym_position =~ /^CC[123]/) {
            my $card = $self->next_cchest;
            if ($card =~ /^(GO|JAIL)$/) {
                $self->set_position($card);
                last ROLL;
            }
        }

        # land on "chance"
        if ($self->sym_position =~ /^CH[123]/) {
            my $card = $self->next_chance;
            if ($card =~ /^(GO|JAIL|C1|E3|H2|R1)$/) {
                $self->set_position($card);
                last ROLL;
            }

            if ($card =~ /back-3/) {
                $self->set_position($self->position() - 3);
                last ROLL;
            }

            # advance to next railroad
            if ($card =~ /next-R/) {
                my $pos = $self->position;
                for my $i (1 .. 10) {
                    my $np = ($pos + $i) % 40;
                    next unless $self->sym_position($np) =~ /^R[1234]$/;
                    $self->set_position($np);
                    last ROLL;
                }
                die "shouldn't get here";
            }

            # advance to next utility
            if ($card =~ /next-U/) {
                my $pos = $self->position;
                for my $i (1 .. 30) {
                    my $np = ($pos + $i) % 40;
                    next unless $self->sym_position($np) =~ /^U[12]$/;
                    $self->set_position($np);
                    last ROLL;
                }
                die "shouldn't get here";
            }

        }

        redo ROLL if $d;
    }

    $self->update_freq;
}

sub set_position {
    my ($self, $pos) = @_;
    if ($pos =~ /^-?\d+$/) {
        $pos += 40 if $pos < 0;
        $self->position($pos);
    }
    else {
        $self->position($self->find_position($pos));
    }
    return $self->position;
}

sub find_position {
    my ($self, $sym) = @_;
    my $first = first_index { $sym eq $_ } SPACES;
    die "position $sym not found" if $first < 0;
    return $first;
}

sub sym_position {
    my $self = shift;
    my $pos = (@_) ? shift() : $self->position;
    my @s = SPACES;
    return $s[$pos];
}

sub update_freq {
    my $self = shift;
    $self->freq->{ $self->position }++;
}

sub summary {
    my $self = shift;
    my %freq = %{ $self->{freq} };
    my @keys = sort { $freq{$b} <=> $freq{$a} } keys %freq;
    my $magic = join "", map { sprintf '%02d', $_ } @keys[0 .. 2];
    my $turns = $self->turns;
    my $out = "turns=$turns\n";
    for my $k (@keys[0 .. 4]) {
        my $sym = $self->sym_position($k);
        my $n = $freq{$k};
        my $pct = 100 * $n / $self->turns;
        $out .= sprintf("%02d (%s) %d/%d %.3f%%\n", $k, $sym, $n, $turns, $pct);
    }
    return $out . ">>> $magic\n";
}

sub advance {
    my ($self,$n) = @_;
    $self->{position} += $n;
    $self->{position} %= 40;
    return $self->{position};
}

sub cchest {
    return $_[0]->{cchest};
}

sub chance {
    return $_[0]->{chance};
}

sub next_cchest {
    my $self = shift;
    my $pos = $self->{cchest_pos} || 0;
    $self->{cchest_pos} = ($pos + 1) % scalar(@{ $self->{cchest} });
    return $self->{cchest}->[$pos];
}

sub next_chance {
    my $self = shift;
    my $pos = $self->{chance_pos} || 0;
    $self->{chance_pos} = ($pos + 1) % scalar(@{ $self->{chance} });
    return $self->{chance}->[$pos];
}

sub die_size {
    my $self = shift;
    if (@_) {
        $self->{die_size} = $_[0];
        warn "# setting die size to $_[0]\n";
    }
    return $self->{die_size};
}

sub throw {
    my $self = shift;
    die "Die size not chosen." unless $self->{die_size};
    return map { int(1 + rand($self->{die_size})) } 0, 1;
}

1;

