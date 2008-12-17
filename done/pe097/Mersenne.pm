#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use Math::BigInt;

unless (caller()) {
    my $x = Math::BigInt->new(2)->bmodpow(7830457,10_000_000_000);
    $x->bmul(28433);
    $x->badd(1);
    print $x->bstr;
}

1;

__END__

The first known prime found to exceed one million digits was discovered in
1999, and is a Mersenne prime of the form 2^6972593-1; it contains exactly
2,098,960 digits. Subsequently other Mersenne primes, of the form 2^p-1, have
been found which contain more digits.

However, in 2004 there was found a massive non-Mersenne prime which contains
2,357,207 digits: 28433 x 2^7830457 + 1.

Find the last ten digits of this prime number.


