#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Math::Combinatorics;
use Gon;

my $c = Math::Combinatorics->new(count => 9, data => [ 1 .. 9 ]);
#my $c = Math::Combinatorics->new(count => 6, data => [ 1 .. 6 ]);

my $count = 0;
while (my @p = $c->next_permutation) {
    my @a = (10, @p[ 0 .. 3 ] );
    my @b = (@p[ 4 .. 8 ] );
    print "@a | @b";
    last if $count++ > 25;
}

