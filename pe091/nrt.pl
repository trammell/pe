#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my @origin = (0,0);
my $DEBUG = 1;

for my $d (0 .. 3) {
    print "nrt($d)=", nrt($d);
    print "nrt_interior($d)=", nrt_interior($d);
    print "nrt_boundary($d)=", nrt_boundary($d);
}

=head2 nrt($d)

Returns the number of triangles OPQ

=cut

my $NRT;

sub nrt {
    my $d = shift;
    return 0 if $d < 1;
    unless (defined $NRT->[$d]) {
        $NRT->[$d] = nrt($d - 1) + nrt_interior($d) + nrt_boundary($d);
    }
    return $NRT->[$d];
}

sub nrt_interior {
    my $d = shift;

    my @edge = map [ $_, $d ], 0 .. $d;

    my $count = 0;

    for my $x (0 .. $d - 1) {
        for my $y (0 .. $d - 1) {
            next unless $x && $y;   # skip (0,0)
            my $vi = [$x,$y];       # vector to interior
            for my $ve (@edge) {    # vector to edge
                my $v = [
                    $vi->[0] - $ve->[0],
                    $vi->[1] - $ve->[1],
                ];
                if (perp($v,$ve)) {
                    $count += 2;
                    next;
                }
                elsif (perp($v,$vi)) {
                    $count += 2;
                    next;
                }
            }
        }
    }

    return $count;
}

sub nrt_boundary {
    my $d = shift;
    return 0 if $d < 1;
    return 3 * (2 * $d - 1);
}

sub perp {
    my ($v,$w) = @_;
    my $dot = $v->[0] * $w->[0] + $v->[1] * $w->[1];
    return (abs($dot) < 1e-9) ? 1 : 0;
}

