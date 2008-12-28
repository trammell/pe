#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;

my @origin = (0,0);

my $count = 0;

while (<>) {
    s/\s//g; 
    $count++ if contains_origin(split /,/, $_);
}

print $count;

sub contains_origin {
    my @p = map [ $_[2*$_], $_[2*$_+1] ], 0 .. 2;
    my $sum = 0;
    for my $i ([0,1],[1,2],[2,0]) {
        my @p1 = @{ $p[ $i->[0] ] };
        my @p2 = @{ $p[ $i->[1] ] };
        my @v1 = makevec(@p1, @p2);
        my @v2 = makevec(@p1, @origin);
        my $z = cpz(@v1,@v2);
        $sum += ($z < 0) ? -1 : 1;
    }
    return abs($sum) == 3;
}

sub makevec {
    my @p1 = @_[0,1];
    my @p2 = @_[2,3];
    return map { $p2[$_] - $p1[$_] } 0, 1;
}

# return the "z" component of the cross product
sub cpz {
    my @v1 = @_[0,1];
    my @v2 = @_[2,3];
    return $v1[0] * $v2[1] - $v1[1] * $v2[0];
}

__END__

http://projecteuler.net/index.php?section=problems&id=102

Problem 102
12 August 2005

Three distinct points are plotted at random on a Cartesian plane, for which
-1000 <= x, y <= 1000, such that a triangle is formed.

Consider the following two triangles:

	A(-340,495), B(-153,-910), C(835,-947)

	X(-175,41), Y(-421,-714), Z(574,-645)

It can be verified that triangle ABC contains the origin, whereas triangle
XYZ does not.

Using triangles.txt (right click and 'Save Link/Target As...'), a 27K text
file containing the co-ordinates of one thousand "random" triangles, find
the number of triangles for which the interior contains the origin.

NOTE: The first two examples in the file represent the triangles in the
example given above.

