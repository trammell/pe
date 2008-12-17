#!/usr/bin/perl -l

use strict;
use warnings;
my $N;

sub n {
    my $x = shift;
    my $y = shift;
    return 0 if $x < 0 || $y < 0;
    return 1 if $x == 0 || $y == 0;
    if (@_) {
        $N->[$x][$y] = $N->[$y][$x] = $_[0];
    }
    $N->[$x][$y] ||= n($x - 1,$y) + n($x, $y - 1);
}

for (1 .. 20) {
    print "$_ => ", n($_,$_);

}

__END__

http://projecteuler.net/index.php?section=problems&id=15

Starting in the top left corner of a 2x2 grid, there are 6 routes (without
backtracking) to the bottom right corner.

How many routes are there through a 20x20 grid?

   1x1 => 2

   2x1 => 3
   2x2 => 6

   3x1 => ?
   3x2 => ?
   3x3 => ?

