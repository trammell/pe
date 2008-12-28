#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use List::Util 'sum';

my @F = (1);
for (1 .. 9) { $F[ $_ ] = $_ * $F[ $_ - 1 ]; }
print "F: @F";

my @sfd;
for my $i (0 .. 2_500_000) {
    print "init: i=$i" if $i % 100_000 == 0;
    $sfd[$i] = sum map { $F[$_] } split //, $i;
}

my $count = 0;

for my $i (0 .. 1_000_000) {
    print "search: i=$i count=$count" if $i % 10_000 == 0;
    my %seen;
    my @trail;
    for (my $x = $i; !$seen{$x}; $x = $sfd[$x]) {
        $seen{$x} = 1;
        push @trail, $x;
    }
    next if scalar(@trail) != 60;
    $count++;
}

print $count;

__END__

http://projecteuler.net/index.php?section=problems&id=74

Problem 74
16 July 2004

The number 145 is well known for the property that the sum of the factorial
of its digits is equal to 145:

    1! + 4! + 5! = 1 + 24 + 120 = 145

Perhaps less well known is 169, in that it produces the longest chain of
numbers that link back to 169; it turns out that there are only three such
loops that exist:

    169 => 363601 => 1454 => 169
    871 => 45361 => 871
    872 => 45362 => 872

It is not difficult to prove that EVERY starting number will eventually get
stuck in a loop. For example,

    69 => 363600 => 1454 => 169 => 363601 => 1454
    78 => 45360 => 871 => 45361 => 871
    540 => 145 => 145

Starting with 69 produces a chain of five non-repeating terms, but the
longest non-repeating chain with a starting number below one million is
sixty terms.

How many chains, with a starting number below one million, contain exactly
sixty non-repeating terms?

Answer: 402
