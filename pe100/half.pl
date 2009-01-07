#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

for my $b (1 .. 1000) {
    next unless (8 * $b * ($b-1)) % 4 == 3;
    print $b;
}


