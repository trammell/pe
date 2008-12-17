#!/usr/bin/perl -l

use strict;
use warnings;

# 16/64 = 1/4
# 19/95 = 1/5
# 49/98 = 4/8
# 26/65 = 2/5

#    (1/4) * (1/5) * (1/2) * (2/5)
#    (1/4) * (1/5) * (1/5)
#    = 1/100

#    AB/BC = A/C
#    AB * C = A * BC

unless (caller()) {

    for my $a (0 .. 9) {
        for my $b (0 .. 9) {
            for my $c (0 .. 9) {
                next if $a == $b && $b == $c;
                next if $b == 0 && $c == 0;
                next if $a == 0 && $b == 0;
                next if $a == 0 && $c == 0;
                next unless (10 * $a + $b) * $c == $a * (10 * $b + $c);
                print " $a$b / $b$c = $a/$c";
            }
        }
    }

}

1;


__END__

The fraction 49/98 is a curious fraction, as an inexperienced mathematician in
attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is
correct, is obtained by cancelling the 9s.

We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

There are exactly four non-trivial examples of this type of fraction, less than
one in value, and containing two digits in the numerator and denominator.

If the product of these four fractions is given in its lowest common terms,
find the value of the denominator.

