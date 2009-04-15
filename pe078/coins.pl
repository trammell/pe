#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings FATAL => 'all';
use lib '../lib';

use Partition 'Pt';

Partition::init(100);

my @n = (
    4, 24, 99, 599, 2474, 14974, 14974, 30599, 46224, 61849, 77474, 93099
);

for my $n (@n) {
    print "n=$n";
    my $pt = Pt(1,$n);
    print "    Pt(1,$n)=$pt";
   # last if $pt % 1_000_000 == 0;
}

