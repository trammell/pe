#!/usr/bin/perl -l

package Pow;

use strict;
use warnings;
use Math::BigInt;

my $sum = Math::BigInt->bzero;

for (1 .. 1000) {
    print "$_..." if $_ % 25 == 0;
    $sum += Math::BigInt->new($_)->bpow($_);
}

print $sum;


__END__

The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.

Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.



