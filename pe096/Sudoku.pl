#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use List::MoreUtils 'first_index';

my @puzzles = load();

my $sum = 0;

my @row;
my @col;
my @box;
for my $i (0 .. 80) {
    push @{ $row[ row($i) ] }, $i;
    push @{ $col[ col($i) ] }, $i;
    push @{ $box[ box($i) ] }, $i;
}

#print "@{$box[1]}"; exit;

for my $i (0 .. $#puzzles) {
    my $p = $puzzles[$i];
    die unless @$p == 81;
    my @s = solve($p);
    my $num = $s[0] . $s[1] . $s[2];
    print "num($i)=$num";
    $sum += $num;
}

print "sum=$sum";

sub solve {
    my $grid = shift;
    my @queue = ($grid);

    QUEUE:
    while (@queue) {
        my $g = shift @queue;

        # first, fill in all cells that have only one solution (also look
        # for any cells that have NO solution)
        for my $i (grep { $g->[$_] == 0 } 0 .. 80) {
            my @exclude = grep { $_ > 0 } map { $g->[$_] } peers($i);
            my @ok = complement(@exclude);
            next QUEUE if @ok == 0;         # no solutions
            $g->[$i] = $ok[0] if @ok == 1;  # one solution
        }

        # now find the first open cell, and generate queue entries for all
        # the possible entries in that cell
        my $i = first_index { $_ == 0 } @$g;
        return @$g if $i < 0;
        my @exclude = grep { $_ > 0 } map { $g->[$_] } peers($i);
        my @ok = complement(@exclude);
        for my $ok (@ok) {
            my @clone = @$g;
            $clone[$i] = $ok;
            push @queue, \@clone;
        }
    }
    die "ran out of queues";
}

sub row { return int($_[0] / 9); }
sub col { return     $_[0] % 9; }
sub box {
    my $row = row($_[0]);
    my $col = col($_[0]);
    if ($col < 3) {
        return 0 if $row < 3;
        return 3 if $row < 6;
        return 6;
    }
    if ($col < 6) {
        return 1 if $row < 3;
        return 4 if $row < 6;
        return 7;
    }
    # $col >= 6;
    return 2 if $row < 3;
    return 5 if $row < 6;
    return 8;
}

my %peers;
sub peers {
    $peers{ $_[0] } ||= [
        @{ $row[ row($_[0]) ] },
        @{ $col[ col($_[0]) ] },
        @{ $box[ box($_[0]) ] },
    ];
    return @{ $peers{$_[0]} };
}

sub complement {
    my %x = map { $_ => 1 } @_;
    return grep { !$x{$_} } 1 .. 9;
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

