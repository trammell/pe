#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;
use List::Util 'min';

# initialize the path sum (x=0)

foreach my $y (0 .. 79) {
    p( 0,$y, w(0,$y) );
}

#print join q( ), map { p(0,$_) } 0 .. 79;

for my $x (1 .. 79) {

    #print "x=$x...";

    # set initial value of path sum
    for my $y (0 .. 79) {
        my $ps = p($x - 1,$y) + w($x,$y);
        p($x,$y,$ps);
    }

    #print join q( ), map { p($x,$_) } 0 .. 79;

    # now "relax" the sums for this x

    my $changed = 1;
    while ($changed) {
        $changed = 0;
        for my $y (0 .. 79) {
            my @p = (p($x-1,$y), p($x,$y-1), p($x,$y+1));
            my $min = w($x,$y) + min(@p);
            next unless $min < p($x,$y);
            $changed = 1;
            p($x,$y,$min);
        }
    }

}

my $minpath = min map { p(79,$_) } 0 .. 79;
print "minimum path length: $minpath";

sub load {
    open(my $fh, 'matrix.txt') or die $!;
    my @rows;
    while (<$fh>) {
        s/\s//g;
        push @rows, [ split q(,), $_ ];
    }
    return \@rows;
}

my $W;
sub w {
    my ($x,$y) = @_;
    $W ||= load();
    return 1e100 if $x < 0 || $x > 79;
    return 1e100 if $y < 0 || $y > 79;
    return $W->[$y][$x];
}

my $P;
sub p {
    my $x = shift;
    my $y = shift;
    return 1e100 if $x < 0 || $x > 79;
    return 1e100 if $y < 0 || $y > 79;
    if (@_) {
        $P->[$y][$x] = $_[0];
    }
    return $P->[$y][$x];
}

1;

__END__

http://projecteuler.net/index.php?section=problems&id=82

Problem 82
05 November 2004

NOTE: This problem is a more challenging version of Problem 81.

The minimal path sum in the 5 by 5 matrix below, by starting in any cell in the
left column and finishing in any cell in the right column, and only moving up,
down, and right, is indicated in red; the sum is equal to 994.

    131 673 234 103 18
    201 96  342 965 150
    630 803 746 422 111
    537 699 497 121 956
    805 732 524 37  331

[Note: the path indicated is "201-96-342-234-103-18".]

Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target
As...'), a 31K text file containing a 80 by 80 matrix, from the left column to
the right column.

