#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Data::Dumper;
local $| = 1;

my @primes = (2,3,5,7,11,13,17,19);

my @try = (2*3*5*7);

my @ok;

for (1 .. 4) {
    print "iteration $_";
    my @tmp;
    for my $t (@try) {
        push @tmp, map { $t * $_ } @primes;
    }
    @try = @tmp;
    for (@try) {
        my @sol = find_solutions($_);
        my $sol = scalar @sol;
        print "$_ => $sol";
        next if $sol < 1000;
        push @ok, [ $_, $sol ];
    }
}

print Dumper(\@ok);

#my @s = find_solutions(6300*7);
#print scalar @s;
exit;

#for my $n (1 .. 10) {
#    print "$n:";
#    my @sol = find_solutions($n);
#    print "   @$_" for @sol;
#}
#exit;

#print for find_solutions(2); exit;

unless (caller()) {
    my @best = (0,0);
    for (my $n=1;;$n++) {
        print "n=$n best=(@best)" if $n % 1000 == 0;
        my @sol = find_solutions($n);
        my $sol = @sol;
        next unless $sol > $best[0];
        @best = ($sol, $n);
        print "new best: @best";
        last if $sol > 1000;
    }
}

my $NSOL;
sub nsol {
    my $n = shift;
    $NSOL->[$n] ||= do {
        my @sol = find_solutions($n);    
        scalar(@sol); 
    };
}

sub find_solutions {
    my $n = shift;
    my @sol;
    for (my $x=$n+1; $x <= 2 * $n; $x++) {
        #print "   x=$x" if $x % 10_000 == 0;
        my $d = $x - $n;
        my $x = $n + $d;
        my $p = $n * $x;
        my $y = $p / $d;
        #print "n=$n d=$d x=$x y=$y"; <STDIN>;
        #last if $y < $n + 0.9;
        next unless $p % $d == 0;
        #print "   x=$x y=$y xmax=$xmax";
        push @sol, [$x,$y];
    }
    return @sol;
}

__END__

http://projecteuler.net/index.php?section=problems&id=108

Problem 108
04 November 2005

In the following equation x, y, and n are positive integers.

    1/x + 1/y = 1/n

For n = 4 there are exactly three distinct solutions:

    1/5 + 1/20 = 1/4
    1/6 + 1/12 = 1/4
    1/8 + 1/8 = 1/4

What is the least value of n for which the number of distinct solutions
exceeds one-thousand?

NOTE: This problem is an easier version of problem 110; it is strongly
advised that you solve this one first.

Analysis:

    we have n,x,y all integers > 0.

Define p=xy (product) and d=x-n (difference)

    1/x + 1/y = 1/n
    1/y = 1/n - 1/x
    1/y = x/(nx) - n/(nx)
    1/y = (x - n)/nx
    y = nx/(x-n)
    y = nx/d

Multiply both sides by nxy:

    ny + nx = xy
    nx = xy - ny
    nx = y(x-n)
    x = y(x-n)/n
    xn = yd 

Also:

    ny + nx = xy
    ny = xy - nx
    ny = x(y-n)
    y = x(y-n)/n
    yn = xd

Also:

    n(x + y) = xy
    x + y = xy/n
    x = xy/n - y
    x = y(x/n - 1)
    y = x / (x/n - 1)

So we must have the following:

    1. n | xy       => n | p
    2. x-n | nx     => d | nx
    3. n | y(x-n)   => n | yd

Setting the limit on X:

    * since y = nx/d, and y,n,x are all > 0, then d > 0
    * x - n > 0, so x > n
    * x = (n+1, n+2, ...)
    * equivalently d=1,2,3,...

Setting the limit on Y:

    1/n = 1/x + 1/y
    
choosing n,x, we get

    1/y = 1/n - 1/x
    1/y = x/(nx) - n/(nx)
    1/y = (x - n)/nx
    y = nx/(x-n)

as x increases, y *decreases*, approaching n for large x.


