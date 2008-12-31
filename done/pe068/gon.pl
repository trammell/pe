#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Math::Combinatorics;
use List::Util 'sum';
use Gon;

my $c = Math::Combinatorics->new(count => 9, data => [ 1 .. 9 ]);
#my $c = Math::Combinatorics->new(count => 6, data => [ 1 .. 6 ]);

my $count = 0;

PERM:
while (my @p = $c->next_permutation) {
    my @a = (10, @p[ 0 .. 3 ] );
    my @b = (@p[ 4 .. 8 ] );
    next unless (sum @b) % 5 == 0;
    for my $i (0 .. 4) {
        next PERM unless $a[$i] + $b[$i] == $a[($i + 1) % 5] + $b[($i + 2) % 5];
    }
    $count++;
    print "n=$count ", as_string(\@a,\@b);
}

