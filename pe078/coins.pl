#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use lib '../lib';

use Partition 'Pt';

my @n = (
    4, 24, 99, 599, 2474, 14974, 14974, 30599, 46224, 61849, 77474, 93099
);

for my $n (@n) {
    my $pt = Pt(1,$n);
    print "n=$n Pt=$pt";
    last if $pt % 1_000_000 == 0;
}

