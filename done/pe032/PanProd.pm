#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use List::Util 'sum';
use Math::Combinatorics;

sub L { return 10 ** ($_[0] - 1); }
sub U { return (10 ** $_[0]) - 1; }

unless (caller()) {
    my %p;

    for my $j (1 .. 4) {
        for my $k (map { $_ - $j } 4,5,6) {
            for my $x (L($j) .. U($j)) {
                for my $y (L($k) .. U($k)) {
                    my $z = $x * $y;
                    next unless is_pandigital($x,$y,$z);
                    print "$x x $y = $z";
                    $p{$z} = 1;
                }
            }
        }
    }
   my @p = keys %p;
   print "products are: @p";
   print sum keys %p;

#    for my $ndigits (1 .. 10) { printf "%d => %d, %d\n", $ndigits, L($ndigits), U($ndigits); 
#   }
#       print "$a ..." if $a % 10_000 == 0;
#
#       for my $b (1 .. 999999) {
#           my $c = $a * $b;
#           next unless is_pandigital($a,$b,$c);
#           print "$a x $b = $c";
#           $p{$c} = 1;
#       }
#   }
}

sub is_pandigital {
    my $s = join q(), @_;
    return 0 if length($s) != 9;
    return 0 if $s =~ /0/;
    return 0 if $s =~ /(\d).*\1/;
    return 1;
}

1;

__END__

The product 7254 is unusual, as the identity, 39 x 186 = 7254, containing
multiplicand, multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can
be written as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only
include it once in your sum.



