#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my @origin = (0,0);
my $DEBUG = 1;

for my $d (0 .. 3) {
    print "nrt_edge($d)=", nrt_edge($d);
}

=head2 nrt($d)

Returns the number of triangles OPQ




=cut

sub nrt {
    my $d = shift;


}

sub nrt_edge {
    my $d = shift;

    # list all points on the boundary
    my @edge;
    push @edge, map [ $_, $d ], 0 .. $d;
    push @edge, map [ $d, $_ ], 0 .. $d - 1;

    # NOTE: can get a 50% speedup if we exploit symmetry here

    my $count = 0;

    for my $x1 (0 .. $d) {
        for my $y1 (0 .. $d) {
            next if $x1 == 0 && $y1 == 0;
            for my $p (@edge) {
                my ($x2,$y2) = @$p;
                next if $x1 == $x2 && $y1 == $y2;

                if ($y1 == 0) {
                    if ($x2 == 0) {
                        $count++;
                    }
                    elsif ($x1 > 0 && $x1 == $x2) {
                        $count++;
                    }
                }
                elsif ($x1 == 0) {
                    if ($y1 > 0 && $y1 == $y2) {
                        $count++;
                    }
                }
            }
        }
    }

    return $count;

}




