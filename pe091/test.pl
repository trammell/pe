#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';
use NRT qw/Q/;
use Test::More;

plan 'no_plan';

my @tests = (
    # $s, Q($s)
    [ -1, 0 ],
    [ 0,  0 ],
    [ 1,  0 ],
    [ 2,  2 ],
    [ 3,  4 ],
    [ 4,  8 ],
    [ 5,  12 ],
    [ 6,  14 ],
    [ 7,  20 ],
    [ 8,  24 ],
);

for my $t (@tests) {
    my ($s, $q) = @$t;
    is(Q($s), $q, "Q($s) should be $q");
}
