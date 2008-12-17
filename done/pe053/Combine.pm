#!/usr/bin/perl -l

package Combine;

use strict;
use warnings;
use Data::Dumper;

unless (caller()) {
    my $a = 1_000_000;
    my $count = 0;
    N:
    for my $n (23 .. 100) {
        for my $r (0 .. $n) {
            my $c = f($n) / ( f($r) * f($n - $r));
            next unless $c > $a;
            #print "C($n,$r) = $c";
            $count++
            #$count += $n - 2 * $r + 3;
            #next N;
        }
    }
    print $count;
}

my @F;
sub f {
    return if $_[0] < 0;
    $F[ $_[0] ] ||= fac($_[0]);

}

sub fac {
    return 1 if $_[0] == 0;
    return 1 if $_[0] == 1;
    return $_[0] * f($_[0] - 1);
}

1;

__END__

=head2 The Problem

=over 4

There are exactly ten ways of selecting three from five, 12345:

    123, 124, 125, 134, 135, 145, 234, 235, 245, and 345

In combinatorics, we use the notation, C(5,3) = 10.

In general,

    C(n,r) = n! / (r!(n-r)!)

where r <= n, n! = n x (n-1) x ... 3 x 2 x 1, and 0! = 1.

It is not until n = 23, that a value exceeds one-million: C(23,10) = 1144066.

How many, not necessarily distinct, values of C(n,r), for 1 <= n <= 100, are
greater than one-million?

=back

=head2 Analysis

For a given n, we're interested in the smallest r such that C(n,r) > a, where
in this problem a = 1_000_000.

    n! / (r! * (n-r!)) > a
    n! > a * r! * (n-r)!

There are n+1 values of r.  We've eliminated r-1 of them, and there are another r-1

    n + 1 - (r - 1) - (r - 1)
    n + 1 - r + 1 - r + 1
    n - 2r + 3

Once we have this smallest r, then there are ...

