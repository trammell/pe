#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Math::BigFloat;

# make an iterator
# generate a's until we see a pattern
# get the period

my $odd = 0;

for my $n (1 .. 10_000) {
    my $p = period($n);
    next if $p % 2 == 0;
    $odd++;
}

print $odd;

sub period {
    my $d = shift;
    my $s = Math::BigFloat->new("$d")->bsqrt();
    my $it = ConFrac::make_iterator($s);

    my @seq;
    my %seen;

    for (my $i=0;;$i++) {
        my ($a,$num,$den,$next) = $it->();
        my $key = join q( ), $a->bstr, $next->copy->bround(20)->bstr;
        push @seq, $key;
        last if $seen{ $key };
        $seen{ $key } = 1;
    }

    # now find the period

    my @r = reverse @seq;

}



__END__

http://projecteuler.net/index.php?section=problems&id=64

Problem 64
27 February 2004

All square roots are periodic when written as continued fractions and can
be written in the form:

It can be seen that the sequence is repeating. For conciseness, we use the
notation sqrt(23) = [4;(1,3,1,8)], to indicate that the block (1,3,1,8)
repeats indefinitely.

The first ten continued fraction representations of (irrational) square
roots are:

    sqrt(2)  = [1;(2)],         period=1
    sqrt(3)  = [1;(1,2)],       period=2
    sqrt(5)  = [2;(4)],         period=1
    sqrt(6)  = [2;(2,4)],       period=2
    sqrt(7)  = [2;(1,1,1,4)],   period=4
    sqrt(8)  = [2;(1,4)],       period=2
    sqrt(10) = [3;(6)],         period=1
    sqrt(11) = [3;(3,6)],       period=2
    sqrt(12) = [3;(2,6)],       period=2
    sqrt(13) = [3;(1,1,1,1,6)], period=5

Exactly four continued fractions, for N <= 13, have an odd period.

How many continued fractions for N <= 10000 have an odd period?

