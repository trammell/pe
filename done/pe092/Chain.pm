#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use List::Util 'sum';
$| = 1;

print "initializing lookup tables";
my @ssd = map ssd($_), 0 .. 9_999;
print "ssd: @ssd[0 .. 19]";
print "done initializing lookup tables";

my $count = 0;

my %chain = ( 1 => 1, 89 => 89 );

for my $n (1 .. 9_999_999) {
    my $r;
    my @equiv;
    while (!$chain{$n}) {
        push @equiv, $n;
        $n = $ssd[$n % 10_000] + $ssd[ int($n / 10_000) ];
    }
    $chain{$_} = $chain{$r} for @equiv;
    print "$_ r=$r count=$count ..." if $_ <= 10 || $_ % 100_000 == 0;
    next if $r == 1;
    $count++;
}

print $count;

# sum the squares of the digits, with limited input range (0 .. 9999)
sub ssd {
    my $n = shift;
    return 0 if $n < 1;
    my $sum = 0;
    while ($n > 0) {
        $sum += ($n % 10) * ($n % 10);
        $n = int ($n / 10);
    }
    return $sum;
}

__END__

http://projecteuler.net/index.php?section=problems&id=92

Problem 92
01 April 2005

A number chain is created by continuously adding the square of the digits
in a number to form a new number until it has been seen before.

For example,

    44 => 32 => 13 => 10 => 1 => 1
    85 => 89 => 145 => 42 => 20 => 4 => 16 => 37 => 58 => 89

Therefore any chain that arrives at 1 or 89 will become stuck in an endless
loop. What is most amazing is that EVERY starting number will eventually
arrive at 1 or 89.

How many starting numbers below ten million will arrive at 89?

Analysis:

    2 - 4 - 16 - 37 - 58 - 89
    9 - 81 - 65 - 61 - 
