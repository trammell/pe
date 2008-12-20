#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=78 :

package Cycle;

use strict;
use warnings;
use base 'Exporter';
use Math::BigFloat;
use List::Util 'max';
use Data::Dumper;

our @EXPORT_OK = qw( cycle invert find_cycle );

unless (caller()) {
    my $max = [0,0];
    for (1 .. 1000) {
        print "$_ ..." if $_ % 50 == 0;
        my $len = length(find_cycle($_));
        next unless $len > $max->[1];
        $max = [$_,$len];
        print "=> @$max";
    }
    print Dumper $max;
}

sub find_cycle {
    my $n = shift;
    my $a = 0;
    while (1) {
        $a += 100;
        my $s = invert($n,$a);
        $s = substr($s,int($a/2));
        return $1 if $s =~ /^(\d+)\1{5,}/;
    }
}

#for my $acc (10,20,50,100,200,500,1000) {
#   for my $acc (10,20,50,100,200,500,1000) {
#       my $c1 = cycle(invert($n,$acc));
#       my $c2 = cycle(invert($n,$acc * 2));
#       return $c1 if $c1 == $c2;
#   }

sub invert {
    my ($n, $accuracy) = @_;
    my $one = Math::BigFloat->bone();
    $one->accuracy($accuracy);
    return $one->bdiv($n)->bstr;
}

sub cycle {
    my $dec = shift;
    if ($dec =~ /\.\d*?(\d+?)\1{5,}/) {
        return $1;
    }
}

1;

__END__

A unit fraction contains 1 in the numerator. The decimal representation of the
unit fractions with denominators 2 to 10 are given:

    1/2  = 0.5
    1/3  = 0.(3)
    1/4  = 0.25
    1/5  = 0.2
    1/6  = 0.1(6)
    1/7  = 0.(142857)
    1/8  = 0.125
    1/9  = 0.(1)
    1/10 = 0.1

Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be
seen that 1/7 has a 6-digit recurring cycle.

Find the value of d < 1000 for which 1/d contains the longest recurring cycle
in its decimal fraction part.

