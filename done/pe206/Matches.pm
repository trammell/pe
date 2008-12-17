#!/usr/bin/perl

# http://projecteuler.net/index.php?section=problems&id=206

package main;

use strict;
use warnings;
use diagnostics;
use Math::BigInt;

our %DIGITS = (
    0  => 0,
    2  => 9,
    4  => 8,
    6  => 7,
    8  => 6,
    10 => 5,
    12 => 4,
    14 => 3,
    16 => 2,
    18 => 1,
);

sub matches {
    (my $n = join q(), @_) =~ s/\s//g;
    my @d = reverse split //, $n;
    return 0 if scalar(@d) > 19;
    for my $k (keys %DIGITS) {
        next if $#d < $k;
        return 0 if $d[$k] != $DIGITS{$k};
    }
    return 1;
}

my %sq;
sub square {
    $sq{ $_[0] } ||= Math::BigInt->new("$_[0]")->bpow(2)->bstr;
}

1;

