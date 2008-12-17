#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;

unless (caller()) {
    for (1 .. 100) {
        my $np = nways($_);
        print "$_ => $np";
    }
}

=head2 nways($n)

Function C<nways($n)> returns the number of B<distinct> ways to rewrite $n as a
sum of two or more positive integers.

    nways(1);   # returns 0
    nways(2);   # returns 1 (1+1)
    nways(3);   # returns 2 (2+1,1+1+1)

Note that C<2+1> and C<1+2> are not distinct, so C<nways(3)> returns 2.

=cut

my %cache;

sub nways {
    my $n = shift;
    return 0 if $n < 2;
    $cache{ $n } ||= _nw($n);
}

sub _nw {
    my $n = shift;
    return 1 if $n == 2;    # 1+1
    return 2 if $n == 3;    # 2+1, 1+1+1
    my $np;
    for my $i (reverse(1 .. $n-1)) {
        my $j = $n - $i;
        $np += nways($j);
    }
    return $np;
}


1;

__END__

http://projecteuler.net/index.php?section=problems&id=76

Problem 76
13 August 2004

It is possible to write five as a sum in exactly six different ways:

    4 + 1
    3 + 2
    3 + 1 + 1
    2 + 2 + 1
    2 + 1 + 1 + 1
    1 + 1 + 1 + 1 + 1

How many different ways can one hundred be written as a sum of at least two
positive integers?

Analysis:

    nw(1) = 0       1+?
    nw(2) = 1       1+1
    nw(3) = 2       1+1+1, 1+2
    nw(4) = 4       1+1+1+1, 1+1+2, 2+2, 1+3
    nw(5) = 6
    nw(6) = 0

Answer:

    It's in wikipedia!
    http://en.wikipedia.org/wiki/Partition_function_(number_theory)
