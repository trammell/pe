#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Sieve max => 10_000;
use Data::Dumper;

my %equiv;

for my $i (1000 .. 9999) {
    next unless Sieve->is_prime($i);
    my $j = sprintf '%04d', $i;
    push @{ $equiv{ canon($j) } }, $j;
}

foreach my $k (keys %equiv) {
    next if @{ $equiv{$k} } < 3;
    check(@{$equiv{$k}});
}

#print Dumper(\%equiv);

sub check {
    #print "checking @_";
    my %x = map { $_ => 1 } @_;
    for my $i (1 .. $#_) {
        for my $j (0 .. $i - 1) {
            my $sum = $_[$i] + $_[$j];
            next if $sum % 2 == 1;
            my $avg = $sum / 2;
            if ($x{$avg}) {
                my @t = sort $_[$i], $_[$j], $avg;
                print "triplet: @t => ", @t;
            }
        }
    }
}

sub canon {
    return join q(), sort split //, $_[0];
}

__END__

http://projecteuler.net/index.php?section=problems&id=49

Problem 49
01 August 2003

The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
increases by 3330, is unusual in two ways: (i) each of the three terms are
prime, and, (ii) each of the 4-digit numbers are permutations of one
another.

There are no arithmetic sequences made up of three 1-, 2-, or 3-digit
primes, exhibiting this property, but there is one other 4-digit increasing
sequence.

What 12-digit number do you form by concatenating the three terms in this
sequence?

