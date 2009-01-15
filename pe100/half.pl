#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';

my $r2 = sqrt(2) / 2;

print "r2=$r2";

for (my $t = 2; $t < 50; $t++) {
    my $b = 1 + int($t * $r2);
    my $f = $t * ($t - 1) / ( $b * ($b - 1));
    print "$t, $b, $f";
}



for my $b (1 .. 1000) {
    my $m = 8 * $b * ($b - 1);
    next unless (8 * $b * ($b-1)) % 4 == 3;
    print $b;
}


