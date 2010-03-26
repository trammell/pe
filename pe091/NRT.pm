#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my @origin = (0,0);
my $DEBUG = 1;


my @correct = (0,3,14,33,62,101,148);

for my $d (0 .. $#correct) {
    my $nrt = nrt($d);
    print "nrt($d)=$nrt";
    next if $nrt == $correct[$d];
    warn "!!! got nrt($d)=$nrt; correct value is $correct[$d]\n";
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
        $NRT->[$d] = nrt_edge($d) + nrt_interior($d);
    }
    return $NRT->[$d];
}

# return the number of triangles with one point on the origin and the other
# two points both on the "edge" (X=0, X=a, Y=0, Y=a).
#   a=1 => 3
#   a=2 => 9
#   a=3 => 15
sub nrt_edge {
    my $a = shift;
    return 6 * $a - 3;
}

# Return the number of triangles witn one point on the origin, one point on
# the "edge", and one point in the interior of the box.
sub nrt_interior {
    my $d = shift;
    my @ep = edge_points($d);
    my $count = 0;

    for my $x (0 .. $d - 1) {
        for my $y ($x .. $d - 1) {
            next unless $x && $y;   # skip (0,0)
            for my $e (@ep) {
                $count += 2 if is_rt([$x,$y],$e);
            }
        }
    }

    return $count;
}

# list all points on the outer edge of the box (i.e. the lines X=d, Y=d)
sub edge_points {
    my $d = shift;
    my @edge = map [ $_, $d ], 0 .. $d;
    push @edge, map [ $d, $_ ], reverse 0 .. $d - 1;
    return @edge;
}

# return true if the points, together with the origin, represent a right
# triangle
sub is_rt {
    my @p = @{ $_[0] };
    my @q = @{ $_[1] };

    # is OP perpendicular to PQ?
    my $t1 = $p[0] * ($p[0] - $q[0]) + $p[1] * ($p[1] - $q[1]);
    #print "t1=$t1";
    return 1 if abs($t1) < 1e-9;

    # is OQ perpendicular to PQ?
    my $t2 = $q[0] * ($p[0] - $q[0]) + $q[1] * ($p[1] - $q[1]);
    #print "t2=$t2";
    return 1 if abs($t2) < 1e-9;

    return 0;
}

# returns true if vectors (u,v) are perpendicular
sub perp {
    my ($u,$v) = @_;
    return (abs($u->[0] * $v->[0] + $u->[1] * $v->[1]) < 1e-9) ? 1 : 0;
}

