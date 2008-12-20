#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use Test::More 'no_plan';

use_ok('Trunc','trunc');

my @tests = (
    #[ input => correct_output ]
    #[ 1 => 1 ],
    #[ 12 => 12, 21 ],
    #[ 123 => 123, 231, 312 ],
    #[ 1234 => 1234, 2341, 3412, 4123 ],
    [ 3797 => 379, 37, 3, 3797, 797, 97, 7 ]
);

foreach my $t (@tests) {
    my ($in,@correct) = @$t;
    @correct = sort { $a <=> $b } @correct;
    my @actual = sort { $a <=> $b } trunc($in);
    is_deeply(\@actual, \@correct) or do {
        diag Dumper([$in,\@correct,\@actual]);
    };
}

# vim: set ai et ts=4 :
