#!/usr/bin/perl -l

use strict;
use warnings;

package Pal;

unless (caller()) {
    my $sum = 0;
    for (1 .. 999_999) {
        next unless is_decimal_palindrome($_);
        next unless is_binary_palindrome($_);
        $sum += $_;
    }
    print $sum;
}

sub is_decimal_palindrome {
    my $n = shift;
    return reverse($n) == $n;
}

sub is_binary_palindrome {
    my $n = shift;
    my $b = sprintf "%b", $n;
    return $b eq reverse($b);
}

1;

__END__

The decimal number, 585 = 1001001001_2 (binary), is palindromic in both bases.

Find the sum of all numbers, less than one million, which are palindromic in
base 10 and base 2.

(Please note that the palindromic number, in either base, may not include
leading zeros.)

