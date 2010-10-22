#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use parent 'Exporter';
use Data::Dumper;

our @EXPORT_OK = qw/ N P Q /;
our $VERBOSE;

unless (caller()) {
    my @origin = (0,0);
    my $DEBUG = 1;
    my @correct = (0,3,14,33,62,101,148,);
    my $T;

    print " i     P      Q      N      T    correct?\n";
    print "---  -----  -----  -----  -----  --------\n";

    for my $i (0 .. $#correct) {
        my $P = P($i);
        my $Q = Q($i);
        my $N = $P + $Q;
        $T += $N;
        my $format = "%3d  %5d  %5d  %5d  %5d  %8s\n";
        my $correct = ($T == $correct[$i]) ? 'yes' : 'no';
        printf $format, $i, $P, $Q, $N, $T, $correct;
    }
}

=head2 P($s)

Return the number of triangles with one point on the origin and the other two
points both on the "edge" (i.e. X=0, X=a, Y=0, or Y=a).  Argument C<$s> is the
length of one side of the square.

    P(1) = 3
    P(2) = 9
    P(3) = 15

In general:

    P(s) = 3 * (2s - 1) = 6 * s - 3

=cut

sub P {
    my $s = shift;
    return ($s < 1) ? 0 : 6 * $s - 3;
}

=head2 Q($s)

Return the number of triangles with one point on the origin, one point in the
interior, and one point on the outer edge of the box (one of the lines "x=s",
"y=s").  Argument C<$s> is the length of one side of the square.

=cut

sub Q {
    my $s = shift;
    return 0 if $s < 1;
    my %found;
    for my $p (interior_points($s)) {
        my $x = $p->[0] - ($p->[1] / $p->[0]) * ($s - $p->[1]);
        next if abs($x - int($x)) > 1e-9;
        $x = int($x);
        next if $x < -0.1;
        next if $x > $s + 0.1;
        my $y = $s;
        for my $k ("($p->[0],$p->[1]),($x,$y)", "($p->[1],$p->[0]),($y,$x)")
        {
            warn "## Q: found $k\n" if $VERBOSE;
            $found{ $k } = 1;
        }
    }
    return scalar(keys %found);
}

# list all points on the interior of the box (i.e. the lines X=d, Y=d)
sub interior_points {
    my $i = shift;
    my @points;
    for my $j (1 .. $i) {
        for my $k (1 .. $i - 1) {
            push @points, [$j,$k]
        }
    }
    return @points;
}

# list all points on the outer edge of the box (i.e. the lines X=d, Y=d)
sub edge_points {
    my $d = shift;
    my @edge = map [ $_, $d ], 0 .. $d;
    push @edge, map [ $d, $_ ], reverse 0 .. $d - 1;
    return @edge;
}

1;
