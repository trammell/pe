#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings FATAL => 'all';

unless (caller()) {
    my @x = map { P(1,$_) } 1 .. 20;
    print "@x";
    for my $i (1 .. 10_000) {
        my @n = (
            #5 * $i + 4,
            #125 * $i + 74,
            #125 * $i + 99,
            #125 * $i + 124,
            3125 * $i + 1849,
            3125 * $i + 2474,
            3125 * $i + 3099,
        );
        #print "i=$i n=(@n)" if $i % 4 == 0;
        print "i=$i n=(@n)";
        for (@n) {
            next unless P(1,$_) == 0;
            die "P(1,$_) => ", P(1,$_);
        }
    }
}

my $P;

sub P {
    my ($k,$n) = @_;
    return 0 if $n < 0 || $k < 0;
    return 0 if $k > $n;
    return 1 if $k == $n;
    unless ($P->{$k}{$n}) {
        #print "calculating P($k,$n)";
        for (my $i=$n+1; $i > 0; $i--) {
            my $p1 = P($i+1,$n);
            my $p2 = P($i,$n-$i);
            $P->{$i}{$n} ||= $p1 + $p2;
        }
    }
    return $P->{$k}{$n} % 1_000_000;
}

sub part {
    my ($k,$n) = @_;
    return 0 if $k > $n;
    return 1 if $k == $n;
    my $p1 = P($k+1,$n);
    my $p2 = P($k,$n-$k);
    return ($p1 + $p2) % 1_000_000;
}

1;

