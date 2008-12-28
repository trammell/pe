#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

package Hand;

use strict;
use warnings;

my %rank = (
    A => 14,
    K => 13,
    Q => 12,
    J => 11,
    T => 10,
    map { $_ => $_ } 2 .. 9,
);

sub new {
    my ($class, @cards) = @_;
    my $self = bless {}, $class;
    $self->{cards} = \@cards;

    my $ranks = join q(), sort { $rank{$b} <=> $rank{$a} }
                map { substr($_,0,1) } @cards;
    my $suits = join q(), sort map { substr($_,-1) } @cards;

    if ($ranks =~ /[^AKQJT98765432]/ || $suits =~ /[^CDHS]/) {
        die "bad hand: @cards ranks=$ranks suits=$suits";
    }

    $self->{ranks} = $ranks;
    $self->{suits} = $suits;

    return $self;
}

sub as_string {
    my $self = shift;
    my @cards = @{ $self->{cards} };
    my $v = $self->value;
    return "@cards => $v";
}

sub ranks { return $_[0]->{ranks}; }
sub suits { return $_[0]->{suits}; }

sub value {
    my $self = shift;

    if ($self->royal && $self->flush) {
        return 10;
    }

    if ($self->straight && $self->flush) {
        return 9 + $self->float;
    }

    # four of a kind
    if (my $r = $self->fourkind) {
        return 8 + $self->float($r);
    }

    if (my $r = $self->fullhouse) {
        return 7 + $self->float($r);
    }

    if ($self->flush) {
        return 6 + $self->float;
    }

    if ($self->straight) {
        return 5 + $self->float;
    }

    if (my $r = $self->threekind) {
        return 4 + $self->float($r);
    }

    if (my $r = $self->twopair) {
        return 3 + $self->float($r);
    }

    if (my $r = $self->onepair) {
        return 2 + $self->float($r);
    }

    if (my $r = $self->nopair) {
        return 1 + $self->float($r);
    }

    die "magic hand!";
}

sub float {
    my $self = shift;
    my $ranks = (@_) ? join(q(),@_) : $self->ranks;
    my $denom = 1;
    my $float = 0.0;
    for my $r (split //, $ranks) {
        $denom *= 15;
        $float += $rank{$r} / $denom;
    }
    return $float;
}

sub nopair {
    my $self = shift;
    return $self->ranks if $self->ranks !~ /(.)\1/;
    return;
}

sub onepair {
    my $self = shift;
    if ($self->ranks =~ /(.)\1/) {
        my $p = $1;
        (my $r = $self->ranks) =~ s/$p//g;
        return $p . $r;
    }
    return;
}

sub twopair {
    my $self = shift;
    if ($self->ranks =~ /(.)\1.*(.)\2/) {
        my ($x,$y) = ($rank{$1} > $rank{$2}) ? ($1,$2) : ($2,$1);
        my $r = $self->ranks;
        $r =~ s/$x//g;
        $r =~ s/$y//g;
        return $x . $y . $r;
    }
    return;
}

sub threekind {
    my $self = shift;
    if ($self->ranks =~ /(.)\1\1/) {
        my $p = $1;
        my $r = $self->ranks;
        $r =~ s/$p//g;
        my ($x,$y) = sort { $rank{$b} <=> $rank{$a} } split //, $r;
        return $p . $x . $y;
    }
    return;
}

sub fourkind {
    my $self = shift;
    if ($self->ranks =~ /(.)\1\1\1/) {
        my $p = $1;
        my $r = $self->ranks;
        $r =~ s/$1//g;
        return $p . $r;
    }
    return;
}

sub flush {
    my $self = shift;
    if ($self->suits =~ /^(.)\1\1\1\1$/) {
        return join q(), sort { $rank{$b} <=> $rank{$a} }
            split //, $self->ranks;
    }
    return;
}

sub royal {
    my $self = shift;
    my $royal = ($self->ranks =~ /AKQJT/) ? 1 : 0;
}

sub straight {
    my $self = shift;
    my $regexp = qr{
        AKQJT | KQJT9 | QJT98 | JT987 | T9876 |
        98765 | 87654 | 76543 | 65432
    }x;
    if ($self->ranks =~ /$regexp/i ) {
        return join q(), sort { $rank{$b} <=> $rank{$a} }
            split //, $self->ranks;
    }
    return;
}

sub fullhouse {
    my $self = shift;
    if ($self->ranks =~ /^(.)\1\1(.)\2$/) {
        return "$1$2";
    }
    if ($self->ranks =~ /^(.)\1(.)\2\2$/) {
        return "$2$1";
    }
    return;
}

