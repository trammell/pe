#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;
use Cubes;

my %seen;
my $count = 0;

for my $i (102_345 .. 456_789) {
    print "i=$i" if $i % 5_000 == 0;
    my $d1 = merge($i);
    my $s1 = as_string($d1);
    next unless sides($d1) == 6;
    my $c = complement_of($d1);
    my ($r1, $r2) = mk_range($c);
    for my $j ($r1 .. $r2) {

        my $d2 = merge($c,$j);
        next unless sides($d2) == 6;
        my $s2 = as_string($d2);

        next if $seen{ $s1 }{ $s2 };
        next if $seen{ $s2 }{ $s1 };
        $seen{ $s1 }{ $s2 } = $seen{ $s2 }{ $s1 } = 1;

        if (shows_all($d1,$d2)) {
            $count++;
            print "    $s1 $s2 count=$count";
        }
    }
}

print "final count=$count";

__END__

http://projecteuler.net/index.php?section=problems&id=90

Problem 90
04 March 2005

Each of the six faces on a cube has a different digit (0 to 9) written on it;
the same is done to a second cube. By placing the two cubes side-by-side in
different positions we can form a variety of 2-digit numbers.

For example, the square number 64 could be formed:

          +-----+      +-----+
         /     /|     /     /|
        +-----+ |    +-----+ |
        |     | |    |     | |
        |  6  | +    |  4  | +
        |     |/     |     |/
        +-----+      +-----+

[Forgive my ASCII art. -JT]

In fact, by carefully choosing the digits on both cubes it is possible to
display all of the square numbers below one-hundred: 01, 04, 09, 16, 25, 36,
49, 64, and 81.

For example, one way this can be achieved is by placing {0, 5, 6, 7, 8, 9} on
one cube and {1, 2, 3, 4, 8, 9} on the other cube.

However, for this problem we shall allow the 6 or 9 to be turned upside-down so
that an arrangement like {0, 5, 6, 7, 8, 9} and {1, 2, 3, 4, 6, 7} allows for
all nine square numbers to be displayed; otherwise it would be impossible to
obtain 09.

In determining a distinct arrangement we are interested in the digits on each
cube, not the order.

    {1, 2, 3, 4, 5, 6} is equivalent to {3, 6, 4, 1, 2, 5}
    {1, 2, 3, 4, 5, 6} is distinct from {1, 2, 3, 4, 5, 9}

But because we are allowing 6 and 9 to be reversed, the two distinct sets in
the last example both represent the extended set {1, 2, 3, 4, 5, 6, 9} for the
purpose of forming 2-digit numbers.

How many distinct arrangements of the two cubes allow for all of the square
numbers to be displayed?

Analysis:

    First die:    (000123468) => (0123468)
    Second die:   (149656941) => (14569)
    Union:        (012345689)
    Position=      123456789
    Intersection: (146)

