#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Data::Dumper;
use List::Util 'min';

my $matrix = load();

my @cost;
sub cost {
    my ($i,$j) = @_; 
    return 999_999 if $i < 0 || $j < 0;
    if ($i == 0 && $j == 0) {
        return $matrix->[0][0];
    }
    $cost[$i][$j] ||= do {
        my @costs = (
            cost($i,$j-1) + $matrix->[$i][$j],
            cost($i-1,$j) + $matrix->[$i][$j]
        );
        min @costs;
    };
}

# prepopulate the cost grid to prevent recursion depth errors
for my $i (map { 5 * $_ } 0 .. 15) {
    for my $j (map { 5 * $_ } 0 .. 15) {
        pc($i,$j);
    }
}

# and print the answer
pc(79,79);

# "print cost"
sub pc {
    my ($i,$j) = @_;
    print "cost($i,$j)=", cost($i,$j);
}

sub load {
    open(my $fh, 'matrix.txt') or die $!;
    my @matrix;
    while (<$fh>) {
        s/\s//g;
        push @matrix, [ split(/,/, $_) ];
    }
    return \@matrix;
}

__END__

http://projecteuler.net/index.php?section=problems&id=81

Problem 81
22 October 2004

In the 5 by 5 matrix below, the minimal path sum from the top left to the
bottom right, by only moving to the right and down, is indicated in red and
is equal to 2427.

        131	673	234	103	18
        201	96	342	965	150
        630	803	746	422	111
        537	699	497	121	956
        805	732	524	37	331

[Note: in the original image, the path is 131 => 201 => 96 => 342 => 746 =>
422 => 121 => 37 => 331.]

Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target
As...'), a 31K text file containing a 80 by 80 matrix, from the top left to
the bottom right by only moving right and down.

