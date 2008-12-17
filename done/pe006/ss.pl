#!/usr/bin/perl -l

use strict;
use warnings;
use List::Util 'sum';

# The sum of the squares of the first ten natural numbers is,
#
#    1^2 + 2^2 + ... + 10^2 = 385
#
# The square of the sum of the first ten natural numbers is,
#
#    (1 + 2 + ... + 10)^2 = 55^2 = 3025
#
# Hence the difference between the sum of the squares of the first ten natural
# numbers and the square of the sum is 3025 - 385 = 2640.
#
# Find the difference between the sum of the squares of the first one hundred
# natural numbers and the square of the sum.

my $max = $ARGV[0] || 100;

my $sumsq = sum map { $_ * $_ } 1 .. $max;
my $sqsum = do {
    my $s = sum 1 .. $max;
    $s * $s;
};

print "$sqsum - $sumsq = @{[ $sqsum - $sumsq ]}"

