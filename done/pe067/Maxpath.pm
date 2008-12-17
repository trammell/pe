#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use List::Util 'max';
use Carp 'croak';

our $T = load();

unless (caller()) {

    my $N = 100;
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


sub T {
    my ($row,$col) = @_;
    unless (exists $T->[$row][$col]) {
        warn Dumper($T->[$row]);
        croak "bad coordinate: ($row,$col)";
    }
    $T->[$row][$col];
}

sub load {
    my @rows;
    open(my $t, '<', 'triangle.txt') or die $!;
    while (<$t>) {
        chomp;
        my @r = split(' ', $_);
        push @rows, \@r;
    }
    return \@rows;
}

