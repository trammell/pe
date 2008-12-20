#!/usr/bin/perl -l

use strict;
use warnings;
use Math::BigInt;
use List::Util 'sum';

# n! means n * (n - 1)  ...  3 * 2 * 1
# Find the sum of the digits in the number 100!

my @digits = split //, Math::BigInt->new(100)->bfac;
print sum @digits;

