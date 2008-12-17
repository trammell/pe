#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use Math::BigFloat;
use List::Util 'sum';

Math::BigFloat->accuracy(200);
#Math::BigFloat->precision(110);

my $sum = 0;

for my $n (1 .. 100) {
    next if sqrt($n) - int(sqrt($n)) < 1e-6;
    my $f = Math::BigFloat->new("$n")->bsqrt()->bstr();
    $f =~ s/\D//g;
    #print $f;
    if ($f =~ /^(\d{100})/) {
        my $len = length($1);
        die "wtf" if $len != 100;
        $sum += sum split //, $1;
    }
    else {
        die "huh? $f";
    }

}

print $sum;

1;

__END__

http://projecteuler.net/index.php?section=problems&id=80

Problem 80
08 October 2004

It is well known that if the square root of a natural number is not an integer,
then it is irrational. The decimal expansion of such square roots is infinite
without any repeating pattern at all.

The square root of two is 1.41421356237309504880..., and the digital sum of the
first one hundred decimal digits is 475.

For the first one hundred natural numbers, find the total of the digital sums
of the first one hundred decimal digits for all the irrational square roots.

