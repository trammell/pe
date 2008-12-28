#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Math::BigInt;
use Math::BigFloat;
use ConFrac;

Math::BigFloat->accuracy(100);

our $DEBUG;

#$DEBUG = 1;
#dioph(61);
#exit();

#my @s = map { $_ * $_ } 0 .. 100_000;

my @max;

for my $d (grep { !is_square($_) } 1 .. 1000) {
    my ($num,$den) = dioph($d);
    next unless $num > $max[1];
    @max = ($d, $num);
}

print "@max";

sub is_square {
    my $x = shift;
    my $y = int(sqrt($x));
    return ($y * $y == $x) ? 1 : 0;
}

sub dioph {
    my $d = shift;
    my $s = Math::BigFloat->new("$d")->bsqrt();

    my $it = ConFrac::make_iterator($s);

    for (my $i=0;;$i++) {
        my ($a,$num,$den) = $it->();
        my $q = $num * $num - $d * $den * $den;
        if ($i % 400 == 0 || $DEBUG) {
            print "d=$d i=$i a=$a num=$num den=$den q=$q";
        }
        last if $i > 100 && $DEBUG;
        next if $q != 1;
        return ($num, $den);
    }

#   for (my $x=Math::BigInt->bone; ;$x++) {
#       my $yy = int($x * $x / $d);
#       next unless $yy > 0 && is_square($yy);
#       my $y = sqrt($yy);
#       my $p = $x * $x - $d * $y * $y;
#       next if $p != 1;
#       return ($x,$y);
#       return ($x,sqrt($yy));
#       for (my $y=1; ;$y++) {
#           my $p = $s[$x] - $d * $s[$y];
#           next X if $p < 0;
#           return ($x,$y) if $p == 1;
#       }
#   }
    
}


__END__

Problem 66
26 March 2004

Consider quadratic Diophantine equations of the form:

    x^2 - Dy^2 = 1

For example, when D=13, the minimal solution in x is:

    649^2 - 13*180^2 = 1.

It can be assumed that there are no solutions in positive integers when D
is square.

By finding minimal solutions in x for D = {2,3,5,6,7}, we obtain the
following:

    3^2 - 2 x 2^2 = 1
    2^2 - 3 x 1^2 = 1
    9^2 - 5 x 4^2 = 1   <=
    5^2 - 6 x 2^2 = 1
    8^2 - 7 x 3^2 = 1

Hence, by considering minimal solutions in x for D <= 7, the largest x is
obtained when D=5.

Find the value of D <= 1000 in minimal solutions of x for which the largest
value of x is obtained.

Analysis:

This is Pell's Equation.
