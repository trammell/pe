#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=70 :

package Trunc;

use strict;
use warnings;
use base 'Exporter';
use Prime qw( is_prime iter );

our @EXPORT_OK = qw( is_ltrunc is_rtrunc );

our $DEBUG;

unless (caller()) {
    my $i = 0;
    my $iter = iter();
    my $count = 0;
    my $sum = 0;
    while ($count < 11) {
        $i++;
        my $p = $iter->();
        print "checking n=$i prime=$p ..." if $i % 1000 == 0;

        # a few heuristics...
        next if $p <= 10;
        next if $p =~ /^1/;
        next if $p =~ /1$/;
        next if $p =~ /.2/;
        next if $p =~ /[45680]/;

        next unless is_truncatable($p);
        $count++;
        $sum += $p;
        print "found prime=$p count=$count sum=$sum"
    }
    print "FINAL: count=$count sum=$sum"
}

sub is_truncatable {
    my $p = shift;
    return 0 unless is_rtrunc($p);
    return 0 unless is_ltrunc($p);
    return 1;
}

sub is_rtrunc {
    my $n = shift;
    while ($n > 0) {
        return 0 unless is_prime($n);
        $n = int($n / 10);
    }
    return 1;
}

sub is_ltrunc {
    my $n = shift;
    while (length($n)) {
        return 0 unless is_prime($n);
        $n =~ s/^.(.*)/$1/;
    }
    return 1;
}

1;

__END__

The number 3797 has an interesting property. Being prime itself, it is possible
to continuously remove digits from left to right, and remain prime
at each stage: 3797, 797, 97, and 7. Similarly we can work from right to
left: 3797, 379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left to
right and right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

