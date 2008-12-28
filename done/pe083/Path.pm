#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use List::Util 'min';

# initialize
p(0,0, w(0,0));

my @queue = ([0,0]);

# the algorithm:
#   - pop a coordinate X off the queue
#   - inspect all points adjacent to X
#

while (@queue) {
    my $xy = shift @queue;
    print "@$xy...";
    for my $pq (adjacent(@$xy)) {
        print "   relaxing @$pq";
        next unless relax(@$pq);
        push @queue, $pq;
    }
}

print p(79,79);

sub adjacent {
    my ($x, $y) = @_;
    return (
        [ $x + 1, $y ],
        [ $x, $y + 1 ],
        [ $x - 1, $y ],
        [ $x, $y - 1 ],
    );
}

sub relax {
    my ($x, $y) = @_;
    my @p = grep { $_ } map { p(@$_) } adjacent($x,$y);
    my $min = w($x,$y) + min @p;
    return 0 if $min >= (p($x,$y) || 1e100);
    p($x,$y,$min);
    print "   $x $y => $min";
    return 1;   # relaxed
}

my $P;
sub p {
    my $x = shift;
    my $y = shift;
    return 1e99 if $x < 0 || $x > 79;
    return 1e99 if $y < 0 || $y > 79;
    if (@_) {
        $P->[$y][$x] = $_[0];
    }
    return $P->[$y][$x];
}

my $W;
sub w {
    my ($x, $y) = @_;
    $W ||= load();
    return 1e99 if $x < 0 || $x > 79;
    return 1e99 if $y < 0 || $y > 79;
    return $W->[$y][$x];
}

sub load {
    open(my $fh, "matrix.txt") or die $!;
    my @rows;
    while (<$fh>) {
        s/\s//g;
        push @rows, [ split /,/, $_ ];
    }
    return \@rows;
}

__END__

Problem 83
19 November 2004

NOTE: This problem is a significantly more challenging version of Problem
81.

In the 5 by 5 matrix below, the minimal path sum from the top left to the
bottom right, by moving left, right, up, and down, is indicated in red and
is equal to 2297.
	
    131	673	234	103	18
    201	96	342	965	150
    630	803	746	422	111
    537	699	497	121	956
    805	732	524	37	331
	
[The path is "131-201-96-342-234-103-18-150-111-422-121-37-331".]

Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target
As...'), a 31K text file containing a 80 by 80 matrix, from the top left to
the bottom right by moving left, right, up, and down.

