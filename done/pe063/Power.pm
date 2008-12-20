#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=70 :

use strict;
use warnings;
use Math::BigInt;

my $count;
for my $a (1 .. 100) {
    for my $n (1 .. 100) {
        my $x = Math::BigInt->new($a)->bpow($n);
        next unless length($x->bstr) == $n;
        print "$a ^ $n = $x ($n characters)";
        $count++;
    }
}

print $count;

__END__

The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the 9-digit
number, 134217728=8^9, is a ninth power.

How many n-digit positive integers exist which are also an nth power?

