#!/usr/bin/perl -l

use strict;
use warnings;
use List::Util 'sum';

unless (caller()) {
    my @words = @{ load() };
    @words = grep { is_triangular(letter_score($_)) } @words;
    print scalar @words;
}

sub load {
    my $words = do { local(@ARGV,$/) = ("words.txt"); <> };
    my @words = map { s/\s//g; $_ } map { s/"//g; $_ } split(/,/,$words);
    return [ sort @words ];
}

sub letter_score {
    return sum map { ord($_) - ord('A') + 1 } split //, $_[0];
}

# see http://en.wikipedia.org/wiki/Triangular_numbers#Tests_for_triangular_numbers

my %cache;

sub is_triangular {
    $cache{ $_[0] } ||= _is_t($_[0]);
}

sub _is_t {
    my $n = 0.5 * (sqrt(8 * $_[0] + 1) - 1);
    return (abs($n - int($n)) < 1e-9) ? 1 : 0;
}

sub t {
    return 0.5 * $_[0] * ($_[0] + 1);
}

1;

__END__

The nth term of the sequence of triangle numbers is given by, t(n) = ½n(n+1); so
the first ten triangle numbers are:

    1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

By converting each letter in a word to a number corresponding to its
alphabetical position and adding these values we form a word value. For
example, the word value for SKY is 19 + 11 + 25 = 55 = t(10). If the word value
is a triangle number then we shall call the word a triangle word.

Using words.txt (right click and 'Save Link/Target As...'), a 16K text file
containing nearly two-thousand common English words, how many are triangle
words?

