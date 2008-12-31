#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

sub merge {
    my @d;
    for my $m (@_) {
        if (ref($m) eq 'ARRAY') {
            $d[$_] = 1 for grep { $m->[$_] } 0 .. 9;
        }
        elsif (!ref($m)) {
            $d[$_] = 1 for split //, $m;
        }
        else {
            die "bad merge argument: $m";
        }
    }
    return \@d;
}

sub sides {
    return scalar grep $_, @{ $_[0] };
}

sub mk_range {
    my $n = 6 - sides($_[0]);
    return (0, (10 ** $n) - 1);
}

sub complement_of {
    my $d = shift;
    my @c;
    $c[$_] = 1 for grep { !$d->[$_] } 0, 1, 2, 3, 4, 5, 8;
    return \@c;
}

sub complete {
    my $d = shift;
    my $n = 6 - sides($d);
    my @c;
    for my $s (map { sprintf "%0${n}d", $_ } 0 .. (10 ** $n) - 1) {
        my %tmp = (%$d, map { $_ => 1 } split //, $s );
        next unless scalar(keys %tmp) == 6;
        push @c, \%tmp;
    }
    return @c;
}

sub as_string {
    return join q(), grep { $_[0][$_] } 0 .. 9;
}

sub shows_all {
    my ($d1,$d2) = @_;

    return 0 unless $d1->[6] || $d1->[9] || $d2->[6] || $d2->[9];

    # can we represent "01"?
    return 0 unless
        ($d1->[0] && $d2->[1])
        ||
        ($d1->[1] && $d2->[0]);

    # can we represent "04"?
    return 0 unless
        ($d1->[0] && $d2->[4])
        ||
        ($d1->[4] && $d2->[0]);

    # can we represent "09" (or equivalently "06")?
    return 0 unless
        ($d1->[0] && ($d2->[6] || $d2->[9]))
        ||
        ($d2->[0] && ($d1->[6] || $d1->[9]));

    # can we represent "16" (or equivalently "19")?
    return 0 unless
        ($d1->[1] && ($d2->[6] || $d2->[9]))
        ||
        ($d2->[1] && ($d1->[6] || $d1->[9]));

    # can we represent "25"?
    return 0 unless
        ($d1->[2] && $d2->[5])
        ||
        ($d1->[5] && $d2->[2]);

    # can we represent "36" (or equivalently "39")?
    return 0 unless
        ($d1->[3] && ($d2->[6] || $d2->[9]))
        ||
        ($d2->[3] && ($d1->[6] || $d1->[9]));

    # two-for-one: if we can represent 49, then we can show 64 as well.
    # can we represent "49" (or equivalently "46")?
    return 0 unless
        ($d1->[4] && ($d2->[6] || $d2->[9]))
        ||
        ($d2->[4] && ($d1->[6] || $d1->[9]));

    # can we represent "81"?
    return 0 unless
        ($d1->[8] && $d2->[1])
        ||
        ($d1->[1] && $d2->[8]);

    return 1;
}

1;

