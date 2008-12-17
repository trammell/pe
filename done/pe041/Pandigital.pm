#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use Math::Combinatorics;
use Sieve;
#use Math::Prime::XS 'is_prime';

# 1 2 3  4  5  6  7  8  9
# 1 3 6 10 15 21 28 36 45
# this means we only have to look at 1, 4, 7

unless (caller()) {
    my $biggest = 0;
    for my $n (1, 4, 7) {
        print "n=$n ...";
        my $c = Math::Combinatorics->new(
            count => $n,
            data => [ 1 .. $n ],
        );
        my $i = 0;
        while (my @d = $c->next_permutation()) {
            $i++;
            print "${i}th permutation of $n digits ..." if $i % 100 == 0;
            next if $d[-1] == 0;
            next if $d[-1] == 2;
            next if $d[-1] == 4;
            next if $d[-1] == 5;
            next if $d[-1] == 6;
            my $x = join q(), @d;
            next unless $x > $biggest;
            next unless Sieve::is_prime($x);
            print "new record: $x";
            $biggest = $x;
        }
    }
}

1;

__END__

We shall say that an n-digit number is pandigital if it makes use of all the
digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is
also prime.

What is the largest n-digit pandigital prime that exists?

Analysis:

We don't have to worry about n=5,6,8,9, since all those pandigital numbers are
multiples of 3.

