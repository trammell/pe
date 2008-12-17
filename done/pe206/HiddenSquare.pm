#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use List::Util qw( min max );
use Math::BigInt;
use Matches;

our $DEBUG = 0;

unless (caller()) {
    my %tried;
    my @cand = extend("0");
    while (1) {
        # remove already-tried keys from @cand
        @cand = grep { !$tried{$_} } @cand;

        # strip duplicates from @cand
        @cand = keys %{{ map { $_, 1 } @cand }};

        # strip candidates with more than 10 digits
        @cand = grep { length($_) <= 10 } @cand;

        die "no remaining candidates" unless @cand;

        @cand = sort { length($b) <=> length($a) } @cand;
        print "@{[ scalar @cand ]} candidates remaining.";
        #print "   => @cand";

        my $c = shift @cand;
        my $sq = square($c);
        print "seeding candidate c=$c sq=$sq";

        $tried{$c} = 1;

        last if length($sq) == 19 && matches($sq);

        push @cand, extend($c);
    }
}

sub extend {
    my $n = shift;
    my @match;
    for my $i (1 .. 99) {
        my $x = "$i$n";
        next unless length($x) < 11;
        next unless $x < 1_500_000_000;
        my $s = square($x);
        next unless matches(substr($s, -1 * length($x)));
        push @match, $x;
    }
    return @match;
}

1;

__END__

http://projecteuler.net/index.php?section=problems&id=206

Problem 206
06 September 2008

Find the unique positive integer whose square has the form 1_2_3_4_5_6_7_8_9_0,
where each "_" is a single digit.

Analysis:

Call our desired integer value V.

The square of V is 19 characters long.

V must be between

    sqrt(1020304050607080900) ~ sqrt(1.020 x 10^18)
                              ~ 1.0e9

and

    sqrt(1929394959697989990) ~ sqrt(1.929 x 10^18)
                              ~ 1.4e9

This is a search range of about 4 x 10^8.

We can precompute a table of squares:

    0^2 = 0
    1^2 = 1
    2^2 = 4
    3^2 = 9
    4^2 = 16
    5^2 = 25
    6^2 = 36
    7^2 = 49
    8^2 = 64
    9^2 = 81

So V =~ /0$/.

What numbers have a square that matches /.9.0$/?

    30 => 0900
    70 => 4900

So V =~ /[37]0$/.

What numbers have a square that looks like "?8?9?0"?

    430
    530
    830

How about breaking it down by digits?

    x = 10*a+b => x^2 = 100aa + 20ab + bb

Can we do similar for larger numbers, e.g. "abc", "abcd", ...

How about breaking it down by digits?

Or break down x => by + c, where y = 10^n?

    (by + c)^2 = bbyy + 2byc + cc

This tells us that "b" only affects digits greater than 10^n, not less.

