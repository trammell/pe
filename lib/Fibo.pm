#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

package Fibo;

use strict;
use warnings;
use base 'Exporter';
use Math::BigInt;

our @EXPORT = ('F');

unless (caller()) {
    for (0 .. 2000) {
        my @x = fpow($_);
        print "$_ => @x" if $_ % 200 == 0;
    }
}

sub F {


}

sub fmult {
    my ($a,$b,$c,$d) = @_;
    return (
        $a * ($c + $d) + $b * $c,
        $a * $c + $b * $d
    );
}

sub fpow {
    my $i = shift;
    my @x = (Math::BigInt->bone,Math::BigInt->bzero);
    my @ans = (Math::BigInt->bzero,Math::BigInt->bone);
    while ($i) {
        if ($i % 2) {
            $i--;
            @ans = fmult(@x,@ans);
        }
        else {
            $i /= 2;
            @x = fmult(@x,@x);
        }
    }
    return @ans;
}

