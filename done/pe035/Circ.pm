#!/usr/bin/perl -l
# vim: set ai et ts=4 :

package Circ;

use strict;
use warnings;
use base 'Exporter';
use Prime 'is_prime';

our @EXPORT_OK = qw( rotate );

# The number, 197, is called a circular prime because all rotations of the
# digits: 197, 971, and 719, are themselves prime.
#
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71,
# 73, 79, and 97.
#
# How many circular primes are there below one million?

unless (caller()) {
    my $count = 4;    # 2,3,5,7
    my %circ;
    N:
    foreach my $n (10 .. 1_000_000) {
        print "# checking integer $n" if $n % 10000 == 0;
        next N if $n =~ /[024568]/;
        if ($circ{$n}) {
            $count++;
            next N;
        }
        else {
            my @r = rotate($n);
            for (@r) {
                next N unless is_prime($_);
            }
            print "$n => @r";
            $circ{$_} = 1 for @r;
            $count++;
        }
    }
    print $count;
}

sub rotate {
    my $n = shift;
    return map {
        $n =~ s/^(.)(.*)$/$2$1/;
        $n;
    } 1 .. length($n);
}

1;

