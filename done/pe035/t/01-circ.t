#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use Test::More 'no_plan';

use_ok('Circ','rotate');

my @tests = (
    [ 1 => 1 ],
    [ 12 => 12, 21 ],
    [ 123 => 123, 231, 312 ],
    [ 1234 => 1234, 2341, 3412, 4123 ],
);

foreach my $t (@tests) {
    my ($in,@correct) = @$t;
    my @actual = sort { $a <=> $b } rotate($in);
    is_deeply(\@actual, \@correct) or do {
        diag Dumper(\@actual);
    };
}

# vim: set ai et ts=4 :
