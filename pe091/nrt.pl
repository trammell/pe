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

sub nrt_interior {


}

sub nrt_boundary {
    my $d = shift;
    return 0 if $d < 1;
    return 3 * (2 * $d - 1);
}




