#!/usr/bin/perl -l
# vim: set ai et ts=4 :

use strict;
use warnings;

unless (caller()) {
    my @max = (0,0);
    for my $p (1 .. 999) {
        print "$p..." if $p % 50 == 0;
        my $n = 0;
        for my $a (1 .. $p) {
            for my $b (1 .. $p) {
                my $c = $p - $b - $a;
                next if $c < $a;
                $n++ if $a*$a + $b*$b == $c*$c;
            }
        }
        if ($n > $max[1]) {
            @max = ($p,$n);
            print "$p => $n";
        }
    }
}

__END__

If p is the perimeter of a right angle triangle with integral length sides,
{a,b,c}, there are exactly three solutions for p = 120.

    {20,48,52}, {24,45,51}, {30,40,50}

For which value of p < 1000, is the number of solutions maximised?

