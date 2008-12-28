#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my @P = (0,0);

for my $m (1 .. 100) {
    # Any string of five consecutive terms m^2 - 2 through m^2 + 2 for m>2
    # in the sequence has the corresponding period lengths 4,2,0,1,2.
    next unless $m > 2;
    $P[$m * $m - 2] = 4;
    $P[$m * $m - 1] = 2;
    $P[$m * $m + 0] = 0;
    $P[$m * $m + 1] = 1;
    $P[$m * $m + 2] = 2;
}

check_known();

my $odd = 0;

for my $n (1 .. 10_000) {
    warn "n=$n odd=$odd\n" if $n % 500 == 0;
    # note: we're following the convention that squares have period 0,
    # which works nicely with this problem.
    $odd++ if period($n) % 2 == 1;
}

print "count of numbers with odd period: $odd";

# returns the period of the CF expansion of sqrt($n)
sub period {
    my $n = shift;
    unless (defined $P[$n]) {
        $P[$n] = find_period(sqrt($n));
    }
    return $P[$n];
}

sub find_period {
    my $r = shift;
    my $last = 2 * int($r);
    my $p = 0;
    while (1) {
        $p++;
        $r = 1.0 / ($r - int($r));
        last if int($r) == $last;
    }
    return $p;
}

sub check_known {
    my %known = (
        2   => 1,
        3   => 2,
        4   => 0,
        5   => 1,
        6   => 2,
        7   => 4,
        8   => 2,
        9   => 0,
        10  => 1,
        100 => 0,
        101 => 1,
        102 => 2,
        103 => 12,
        104 => 2,
        105 => 2,
        106 => 9,
        107 => 6,
        108 => 8,
        109 => 15,
    );
    for my $n (sort keys %known) {
        my $p = period($n);
        next unless $p != $known{$n};
        die "Wrong period ($p) for n=$n (should be $known{$n}\n";
    }
    warn "Sanity checks pass.\n";
}

