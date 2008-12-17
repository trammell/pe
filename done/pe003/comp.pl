#!/usr/bin/perl

use strict;
use warnings;
use bigint;

my $comp = 600851475143;

my $i = 1;

while ($i < $comp) {
    $i++;
    while ($comp % $i == 0) {
        print " $i";
        $comp = $comp / $i;
        $i = 2;
    } 
}

