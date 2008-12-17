#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;

my $mm = 2_000_000;

my @closest = (2_000_000,1,1,1);

my $i = 1;
my $j = 1;

MAIN:
while (1) {
    print "$i..." if $i % 50 == 0;
    last if $i > 2010;

    {
        my $k = $j + 1;
        my $n0 = nrec($i,$j);
        my $n1 = nrec($i,$k);

        if ($mm == $n0) { die "nailed it: $i, $j"; }
        if ($mm == $n1) { die "nailed it: $i, $k"; }

        if ($mm < $n0) {
            $j--;
            redo;
        }

        if ($mm > $n1) {
            $j++;
            redo;
        }

        if (abs($n0 - $mm) < $closest[0]) {
            @closest = (abs($n0-$mm),$i,$j,$i*$j);
            print "new closest: @closest";
        }
        if (abs($n1 - $mm) < $closest[0]) {
            @closest = (abs($n1-$mm),$i,$k,$i*$k);
            print "new closest: @closest";
        }

        $i++;
    }
}

print "final closest: @closest";

my @cache;
sub nrec {
    my ($width, $height) = @_;
    ($width,$height) = ($height,$width) if $width < $height;
    $cache[$width][$height] ||= do {
        my $n = 0;
        for my $w (1 .. $width) {
            my $ww = $width - $w + 1;
            my $subtotal = 0;
            for my $h (1 .. $height) {
                $subtotal += $height - $h + 1;
            }
            $n += $ww * $subtotal;
        }
        $n;
    }
}

1;

__END__

http://projecteuler.net/index.php?section=problems&id=85

Problem 85
17 December 2004

By counting carefully it can be seen that a rectangular grid measuring 3 by 2
contains eighteen rectangles:

    (1x1) => 6      # not even going to try ASCII art here...
    (1x2) => 4
    (1x3) => 2
    (2x1) => 3
    (2x2) => 2
    (2x3) => 1

Although there exists no rectangular grid that contains exactly two million
rectangles, find the area of the grid with the nearest solution.

Analysis:

If my nrec() function isn't fast enough, should be possible to convert it into
an analytic solution.

