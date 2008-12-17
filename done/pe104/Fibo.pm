#!/usr/bin/perl -l

package Fibo;

use strict;
use warnings;
use base 'Exporter';
use Math::BigInt;

our @EXPORT_OK = qw(fibonacci);

unless (caller()) {
    print "$_ => @{[ fibpow($_) ]}" for 0 .. 30;
}

sub fibonacci {
    return (fibpow($_[0]))[0];
}

sub ONE {
    return ( Math::BigInt->bzero(), Math::BigInt->bone() );
}

sub X {
    return ( Math::BigInt->bone(), Math::BigInt->bzero() );
}

my @fp;

sub fibpow {
    my $i   = shift;
    @{ $fp[ $i ] ||= do {
        my @x   = X();
        my @ans = ONE();
        while ($i) {
            if ($i % 2) {
                @ans = fibtimes(@x, @ans);
                $i--;
            }
            $i /= 2;
            @x = fibtimes(@x,@x);
        }
        \@ans;
    } };
}

my %ft;
sub fibtimes {
    my ($a, $b, $c, $d) = @_;
    my $m = "@_";
    @{ $ft{$m} ||= [
        $a * ($c + $d) + $b * $c,
        $a * $c + $b * $d,
    ] };
}

1;

__END__

http://en.wikipedia.org/wiki/Fibonacci_number

In mathematics, the Fibonacci numbers are a sequence of numbers named after
Leonardo of Pisa, known as Fibonacci. Fibonacci's 1202 book Liber Abaci
introduced the sequence to Western European mathematics, although the sequence
had been previously described in Indian mathematics.

The first number of the sequence is 0, the second number is 1, and each
subsequent number is equal to the sum of the previous two numbers of the
sequence itself, yielding the sequence 0, 1, 1, 2, 3, 5, 8, etc. In
mathematical terms, it is defined by the following recurrence relation:

    F(n) =  0                   if n == 0;
            1                   if n == 1;
            F(n-1) + F(n-2)     if n > 1

That is, after two starting values, each number is the sum of the two preceding
numbers. The first Fibonacci numbers (sequence A000045 in OEIS), also denoted
as F_n, for n = 0, 1, 2, ..., 20 are:

    F0  F1  F2  F3  F4  F5  F6  F7  F8  F9  F10
    0   1   1   2   3   5   8   13  21  34  55

    F11  F12  F13  F14  F15  F16  F17   F18   F19   F20
    89   144  233  377  610  987  1597  2584  4181  6765

