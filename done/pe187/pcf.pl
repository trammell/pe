#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use lib "$ENV{HOME}/work/project-euler/lib";
use Primes;
use PCF 'pcf';
use List::Util 'sum';

my @primes = primes();

for my $n (10,100,1000,10_000,100_000,1_000_000, 10_000_000, 100_000_000) {
    print "pi2($n)=", pi2($n);
}

sub pi2 {
    my $n = shift;
    my $sum = 0;
    my $maxk = pcf(int(sqrt($n)));
    for my $k (1 .. $maxk) {
        my $pk = $primes[$k - 1];
        my $term = pcf(int($n / $pk)) - $k + 1;
        $sum += $term;
    }
    return $sum;
}

