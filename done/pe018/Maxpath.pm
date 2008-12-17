#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use List::Util 'max';
use Tri 'T';

my @path ;

unless (caller()) {

    my $N = 15;
    my $B = $N - 1;

    my $p;

    foreach my $col (0 .. $B) {
        $p->[$B][$col] = T($B,$col);
    }

    for (my $row = $B - 1; $row >= 0; $row--) {
        foreach my $col (0 .. $row) {
            $p->[$row][$col] = T($row,$col) + max (
                $p->[$row + 1][$col],
                $p->[$row + 1][$col + 1],
            );
        }
    }

    print $p->[0][0];

}

1;

