#!/usr/bin/env perl

use strict;
use warnings FATAL => 'all';

die unless p(10) == 42;
die unless p(20) == 627;
die unless p(30) == 5604;
die unless p(40) == 37338;

for my $n (1 .. 100_000) {
    my $p = p($n);
    if ($n < 11 || $n % 1000 == 0) {
        printf "p(%d) = %d\n", $n, $p;
    }
    if ($p % 1_000_000 == 0) {
        print "n=$n, p=$p\n";
        last;
    }
}

my $P;
sub p {
    my $n = shift;
    $P ||= [ 1, 1, 2, 3 ];
    $P->[$n] ||= do {
        my $i = 1;
        my $sum = 0;
        while (1) {
            my $q = pent($i);
            last if $q > $n;
            my $_p = $P->[$n - $q] || p($n - $q);
            my $term = $_p * ($i % 2 ? 1 : -1);
            $sum += $term;
            $i = ($i > 0) ? -$i : 1 - $i;
        }
        $sum % 1_000_000;
    }
}

# generate pentagonal numbers
sub pent {
    return 0.5 * $_[0] * (3 * $_[0] - 1);
}

