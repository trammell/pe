#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';


my $sum = 0;

for my $a (3 .. 1000) {
    my $mr = maxrem($a);
    $sum += $mr;
    if ($a <= 20) {
        print "maxrem($a)=$mr sum=$sum";
    }
    last if $a > 10;
}

print $sum;

sub maxrem {
    my $a = shift;
    my $rmax = 0;
    my $nmax = 0;
    for my $n (3 .. $a * $a) {
        my $r =((($a - 1) ** $n) + (($a + 1) ** $n)) % ($a * $a);
        next unless $r > $rmax;
        $rmax = $r;
        $nmax = $n;
    }
    print "   r_max($a)=$rmax at n=$nmax";
    return $rmax;
}

