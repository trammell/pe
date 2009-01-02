#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';

my $sum = 0;

for my $a (3 .. 1000) {
    my $mr = maxrem($a);
    $sum += $mr;
}

print $sum;

sub maxrem {
    my $a = shift;
    my $a2 = $a * $a;
    my $rmax = 0;
    my $nmax = 0;
    my $T1 = my $t1 = $a - 1;
    my $T2 = my $t2 = $a + 1;
    my $n = 0;
    while (1) {
        $n++;
        $t1 = ($t1 + $a - 1) % $a2;
        $t2 = ($t2 + $a + 1) % $a2;
        last if $T1 == $t1 && $T2 == $t2;
        my $r = ($t1 + $t2) % $a2;
        next unless $r > $rmax;
        $rmax = $r;
        $nmax = $n;
    }
    print "r_max(a=$a;n=$nmax)=$rmax";
    return $rmax;
}

