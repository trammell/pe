#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my @origin = (0,0);
my $DEBUG = 1;

for my $d (0 .. 3) {
#   print "nrt_edge($d)=", nrt_edge($d);
}

print is_rt([1,1],[0,2]);
print is_rt([1,1],[1,2]);

exit;

=head2 nrt($d)

Returns the number of triangles OPQ in the first quadrant.

=cut

my $NRT;
sub nrt {
    my $d = shift;
    $NRT ||= [0,3];
    unless (defined $NRT->[$d]) {
        $NRT->[$d] = nrt_interior($d) + nrt_edge($d);
    }
    return $NRT->[$d];
}

sub nrt_interior {
    my $d = shift;
    my @ep = edge_points($d);
    my $count = 0;

    for my $x (0 .. $d - 1) {
        for my $y (0 .. $d - 1) {
            next unless $x && $y;   # skip (0,0)
            for my $e (@ep) {
                next unless is_rt([$x,$y],$e);
                $count++;
            }
        }
    }

    return $count;
}

# return the number of triangles with two points on the edge
#   d=1 => 3
#   d=2 => 9
sub nrt_edge {
    my $d = shift;
    return 3 + 
    return 2 * $d + 1;
}

# list all points on the boundary (x == d || y == d)
sub edge_points {
    my $d = shift;
    my @edge = map [ $_, $d ], 0 .. $d;
    push @edge, map [ $d, $_ ], reverse 0 .. $d - 1;
    return @edge;
}

# return true if the points represent a right triangle
sub is_rt {
    my @p = @{ $_[0] };
    my @q = @{ $_[1] };

    # is OP perpendicular to PQ?
    my $t1 = $p[0] * ($p[0] - $q[0]) + $p[1] * ($p[1] - $q[1]);
    #print "t1=$t1";
    return 1 if abs($t1) < 1e-6;

    # is OQ perpendicular to PQ?
    my $t2 = $q[0] * ($p[0] - $q[0]) + $q[1] * ($p[1] - $q[1]);
    #print "t2=$t2";
    return 1 if abs($t2) < 1e-6;

    return 0;
}

