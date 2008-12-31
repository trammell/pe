#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my @P;

init();
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
        $P[$n] = _period($n);
    }
    return $P[$n];
}

sub _period {
    my $n  = shift;
    my $a0 = int(sqrt($n));
    my $b0 = $a0;
    my $c0 = $n - $a0 * $a0;
    my $p  = 0;

    my $a;
    my $b = $b0;
    my $c = $c0;

    do {
        $a = int(($a0 + $b) / $c);
        $b = $a * $c - $b;
        $c = int(($n - $b * $b) / $c);
        $p++;
    } while ($b != $b0) || ($c != $c0);
    return $p;
}

sub init {
    @P = (0,0,1,2,0,1,2);     # period for N=0,1,2,3,4,5,6
    for my $m2 (map { $_ * $_ } 3 .. 100) {
    # Any string of five consecutive terms m^2 - 2 through m^2 + 2 for m>2
    # in the sequence has the corresponding period lengths 4,2,0,1,2.
        $P[$m2 - 2] = 4;
        $P[$m2 - 1] = 2;
        $P[$m2]     = 0;
        $P[$m2 + 1] = 1;
        $P[$m2 + 2] = 2;
    }
}

sub check_known {
    my @correct = (
        0, 0, 1, 2, 0, 1, 2, 4, 2, 0,
        1, 2, 2, 5, 4, 2, 0, 1, 2, 6,
        2, 6, 6, 4, 2, 0, 1, 2, 4, 5,
        2, 8, 4, 4, 4, 2, 0, 1, 2, 2,
        2, 3, 2, 10, 8, 6, 12, 4, 2,
    );
    for my $n (0 .. $#correct) {
        my $p = period($n);
        next unless $p != $correct[$n];
        die "Wrong period ($p) for n=$n (should be $correct[$n])\n";
    }
    warn "Sanity checks pass.\n";
}

