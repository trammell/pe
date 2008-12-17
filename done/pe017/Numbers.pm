#!/usr/bin/perl -l

use strict;
use warnings all => 'FATAL';
package main;
use List::Util 'sum';

# If the numbers 1 to 5 are written out in words: one, two, three, four, five,
# then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out
# in words, how many letters would be used?
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
# forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20
# letters. The use of "and" when writing out numbers is in compliance with
# British usage.

my %S = (
    1  => 'one',
    2  => 'two',
    3  => 'three',
    4  => 'four',
    5  => 'five',
    6  => 'six',
    7  => 'seven',
    8  => 'eight',
    9  => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen',
    20 => 'twenty',
    30 => 'thirty',
    40 => 'forty',
    50 => 'fifty',
    60 => 'sixty',
    70 => 'seventy',
    80 => 'eighty',
    90 => 'ninety',
    1000 => 'one thousand',
);

sub en {
    my $n = shift;
    $S{$n} ||= calc_en($n);
}

sub calc_en {
    my $n = shift;
    if ($n < 100) {
        my $ones = $n % 10;
        my $tens = $n - $ones;
        return sprintf "%s-%s", en($tens), en($ones);
    }
    else {
        my $hundreds = int($n / 100);
        my $remainder = $n - $hundreds * 100;
        if ($remainder) {
            return sprintf "%s hundred and %s", en($hundreds), en($remainder);
        }
        else {
            return sprintf "%s hundred", en($hundreds);
        }
    }
}

sub letter_count {
    my $s = shift;
    $s =~ s/\W//sg;
    return length $s;
}

unless (caller()) {
    print sum map { letter_count(en($_)) } 1 .. 1000;
}

