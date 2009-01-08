#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use lib "$ENV{HOME}/work/project-euler/lib";
use GCD 'gcd';

my $r2 = 0.5 * sqrt(2);

print "r2=$r2";

for (my $t = 1_000_000_000; $t < 50000; $t++) {

    my $b   = 1 + int($t * $r2);
    my @num = ($b, $b - 1);
    my @den = ($t, $t - 1);

    if ((my $gcd = gcd($num[0],$den[1])) > 1) {
        $num[0] /= $gcd;
        $den[1] /= $gcd;
    }

    if ((my $gcd = gcd($num[0],$den[0])) > 1) {
        $num[0] /= $gcd;
        $den[0] /= $gcd;
    }

    if ((my $gcd = gcd($num[1],$den[0])) > 1) {
        $num[1] /= $gcd;
        $den[0] /= $gcd;
    }

    if ((my $gcd = gcd($num[1],$den[1])) > 1) {
        $num[1] /= $gcd;
        $den[1] /= $gcd;
    }

    my $n = $num[0] * $num[1];
    my $d = $den[0] * $den[1];

    if ((my $gcd = gcd($n,$d) > 1)) {
        $n /= $gcd;
        $d /= $gcd;
    }

    next unless $n == 1 and $d == 2;

    print "$t $n $d";
}

