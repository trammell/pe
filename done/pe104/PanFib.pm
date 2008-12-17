#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
#use Fibo 'fibonacci';
use Math::BigFloat;
#use ModNum;

Math::BigFloat->accuracy(12);

local $| = 1;

my $max = 1_000_000;

my %period = (
    1 => 60,
    2 => 300,
    3 => 1_500,
    4 => 15_000,
    5 => 150_000,
    6 => 1_500_000,
    7 => 15_000_000,
    8 => 150_000_000,
    9 => 1_500_000_000,
);

my @low = (0,1,1);
my %pflow;

#my @hi = (Math::BigFloat->bzero,Math::BigFloat->bone);
my @hi = (0,1,1);

for my $i (1 .. $max) {
    print "i=$i..." if $i % 50_000 == 0;
    my $low = $low[ $i ] ||= ($low[$i-1] + $low[$i-2]) % 1_000_000_000;

    my $hi = $hi[ $i ] ||= $hi[$i-1] + $hi[$i-2];

    if ($hi > 1e100) {
        $hi[$i]   *= 1e-99;
        $hi[$i-1] *= 1e-99;
        $hi[$i-2] *= 1e-99;
    }

    next unless is_pd("$low");

    (my $histr = "$hi") =~ s/\.//;

    next unless is_pd(substr($histr,0,9));

    print "testing $i => $low => $hi";

    exit;

    #    $pflow{$i} = $low;
}

exit;

for my $i (sort { $a <=> $b } keys %pflow) {
    print "testing $i => $pflow{$i} => $hi[$i]";
    #my $f = fibonacci($i)->bstr;
    #next unless is_pd( substr($f,0,9) );
    #print "$i";
    #last;
}

my @fib;
sub modfib {
    my $n = shift;
    return ModNum->ONE  if $n == 1;
    return ModNum->ONE  if $n == 2;
    unless (defined $fib[$n]) {
        $fib[$n] = modfib($n - 1) + modfib($n - 2);
    }
    return $fib[$n];
}

sub is_pd {
    my $d = shift;
    return if length($d) != 9;
    return if index($d,"0") != -1;
    return unless $d % 9 == 0;
    return if $d =~ /([1-9]).*\1/;
    return 1;
}

1;

__END__

http://projecteuler.net/index.php?section=problems&id=104

Problem 104
09 September 2005

The Fibonacci sequence is defined by the recurrence relation:

    F(n) = F(n-1) + F(n-2), where F(1) = 1 and F(2) = 1.

It turns out that F(541), which contains 113 digits, is the first Fibonacci
number for which the last nine digits are 1-9 pandigital (contain all the
digits 1 to 9, but not necessarily in order). And F(2749), which contains 575
digits, is the first Fibonacci number for which the first nine digits are 1-9
pandigital.

Given that F(k) is the first Fibonacci number for which the first nine digits
AND the last nine digits are 1-9 pandigital, find k.

========
Analysis
========

From http://mathworld.wolfram.com/FibonacciNumber.html

    The sequence of final digits in Fibonacci numbers repeats in cycles of 60.
    The last two digits repeat in 300, the last three in 1500, the last four in
    15000, etc. The number of Fibonacci numbers between n and 2n is either 1 or
    2 (Wells 1986, p. 65).

So this means:

    1 => 60
    2 => 300
    3 => 1_500
    4 => 15_000
    5 => 150_000
    6 => 1_500_000
    7 => 15_000_000
    8 => 150_000_000
    9 => 1_500_000_000

Perhaps we could use this information to create a sieve to skip uninteresting
values?

    F(7) = 13
    so F(307) =~ /13?/
    so F(607) =~ /13?/

Also from http://mathworld.wolfram.com/FibonacciNumber.html

    The Fibonacci numbers F_n, are squareful  for n=6, 12, 18, 24, 25, 30, 36,
    42, 48, 50, 54, 56, 60, 66, ..., 372, 375, 378, 384, ... (Sloane's A037917)
    and squarefree  for n=1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 13, ... (Sloane's
    A037918). 4|F_(6n) and 25|F_(25n) for all n, and there is at least one
    n<=2m such that m|F_n. No squareful  Fibonacci numbers F_p are known with p
    prime.

Also:

    No squareful Fibonacci numbers F_p are known with p prime.
