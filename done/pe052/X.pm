#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;

unless (caller()) {
    #for (4_000_000 .. 5_000_000) {
    for (0 .. 5_000_000) {
        print "$_ ..." if $_ % 1000 == 0;
        my $x = '1' . $_;
        my $y = join('', sort split(//,$x));
        next unless $y eq join('', sort split(//,2 * $x));
        next unless $y eq join('', sort split(//,3 * $x));
        next unless $y eq join('', sort split(//,4 * $x));
        next unless $y eq join('', sort split(//,5 * $x));
        next unless $y eq join('', sort split(//,6 * $x));
        die $x;
    }
}

sub ss {

}

1;

__END__

It can be seen that the number, 125874, and its double, 251748, contain exactly
the same digits, but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x,
contain the same digits.

