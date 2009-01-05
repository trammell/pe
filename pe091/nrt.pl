#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my @origin = (0,0);
my $DEBUG = 1;

# check the first ten values

my @correct = (0,3,14,33,62,101,148);

for my $d (0 .. $#correct) {
    my $nrt = nrt($d);
    next if $nrt == $correct[$d];
    die "got nrt($d)=$nrt; correct value is $correct[$d]\n";
}

=head2 nrt($d)

Returns the number of triangles OPQ

=cut

my $NRT;

sub nrt {
    my $d = shift;
    return 0 if $d < 1;
    unless (defined $NRT->[$d]) {
        $NRT->[$d] = nrt($d - 1) + calc_nrt($d);
    }
    return $NRT->[$d];
}

sub calc_nrt {
    my $d = shift;
    return 0 if $d < 1;

    my $count = 3 * (2 * $d - 1);

    my @edge = map [ $_, $d ], 0 .. $d;

    for my $x (0 .. $d - 1) {
        for my $y (0 .. $d - 1) {
            next unless $x || $y;   # skip (0,0)
            my $vi = [$x,$y];       # vector to interior
            for my $ve (@edge) {    # vector to edge
                my $v = [
                    $vi->[0] - $ve->[0],
                    $vi->[1] - $ve->[1],
                ];
                if (perp($v,$ve)) {
                    local $" = q(,);
                    print "d=$d found ((0,0) (@$vi) (@$ve))";
                    $count += 2;
                    next;
                }
                elsif (perp($v,$vi)) {
                    local $" = q(,);
                    print "d=$d found ((0,0) (@$vi) (@$ve))";
                    $count += 2;
                    next;
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

