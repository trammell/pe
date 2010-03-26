#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my @origin = (0,0);
my $DEBUG = 1;

for my $d (1 .. 10) {
    print "nrt($d)=", nrt($d);
}

=head2 nrt($d)

Returns the number of triangles OPQ

=cut

my $NRT;

sub nrt {
    my $d = shift;

    my $count = 0;

    # loop over points (u,v) and (x,y), looking for right triangles

    for my $u (0 .. $d) {
        for my $v (0 .. $d) {

            # skip origin
            next unless $u || $v;

            for my $x (0 .. $d) {
                for my $y (0 .. $d) {

                    # skip origin
                    next unless $x || $y;

                    # skip if (u,v) == (x,y)
                    next if ($u == $x) && ($v == $y);

                    # list of three vectors representing the sides of our
                    # triangle
                    my @vec = (
                        [ $u, $v ],             # origin => (u,v)
                        [ $x, $y ],             # origin => (x,y)
                        [ $u - $x, $v - $y ],   # (x,y) => (u,v)
                    );

                    # try all combinations of vectors looking for
                    # perpendiculars
                    for ([0,1],[1,2],[0,2]) {
                        my ($v1, $v2) = @vec[ @$_ ];
                        if (perp($v1,$v2)) {
                            #print "d=$d found (0,0) ($u,$v) ($x,$y)";
                            $count += 0.5;
                            last;
                        }
                    }

                }
            }
        }
    }

    return $count;

}

# calculate dot product; if vectors (v1,v2) are perpendicular the dot product
# is zero.  Return true if vectors (u,v) are perpendicular.
sub perp {
    return abs($_[0][0] * $_[1][0] + $_[0][1] * $_[1][1]) < 1e-9;
}

