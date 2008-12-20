#!/usr/bin/perl -l

use strict;
use warnings;
use Math::BigInt;
use List::Util 'sum';

# 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
# What is the sum of the digits of the number 2^1000?

my @digits = split //, Math::BigInt->new(2)->bpow(1000);
print @digits;
print sum @digits;

