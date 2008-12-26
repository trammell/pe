#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use List::MoreUtils 'firstidx';

my @puzzles = load();

my $sum = 0;

for my $i (0 .. $#puzzles) {
    my $p = $puzzles[$i];
    die unless @$p == 81;
    solve($p);
    my $num = 100 * $p->[0] + 10 * $p->[1] + $p->[2];
    print "num($i)=$num";
    $sum += $num;
}

print "sum=$sum";

sub solve {
    my $grid = shift;
    my $i = firstidx { $_ == 0 } @$grid;

}

sub is_valid {

}

sub load {
    open(my $fh, 'sudoku.txt') or die $!;
    my @puzzles;
    for (1 .. 50) {
        my @grid = map { my $x = <$fh>; $x; } 1 .. 10;
        die "load error" unless $grid[0] =~ /Grid/;
        my $g = join q(), @grid[1..9];
        $g =~ s/\s//g;
        push @puzzles, [ split //, $g ];
    }
    return @puzzles;
}

1;

