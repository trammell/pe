#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my @origin = (0,0);
my $DEBUG = 1;

for my $d (1 .. 5) {
    print "nrt($d)=", nrt($d);
}

=head2 nrt($d)

Returns the number of triangles OPQ

=cut

my $NRT;

sub nrt {
    my $d = shift;

    my $count = 0;

    for my $u (0 .. $d) {
        for my $v (0 .. $d) {
            next unless $u || $v;
            for my $x (0 .. $d) {
                for my $y (0 .. $d) {
                    next unless $x || $y;
                    next if ($u == $x) && ($v == $y);

                    my @s = (
                        [ $u, $v ],
                        [ $x, $y ],
                        [ $u - $x, $v - $y ],
                    );

                    for ([0,1],[1,2],[0,2]) {
                        my ($s1, $s2) = @s[ @$_ ];
                        if (perp($s1,$s2)) {
                            print "d=$d found (0,0) ($u,$v) ($x,$y)";
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

# returns true if vectors (u,v) are perpendicular
sub perp {
    my ($u,$v) = @_;
    return (abs($u->[0] * $v->[0] + $u->[1] * $v->[1]) < 1e-9) ? 1 : 0;
}

