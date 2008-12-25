#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :
# An attempted solution to Project Euler problem 51.

use strict;
use warnings FATAL => 'all';
use lib "$ENV{HOME}/work/project-euler/lib";
use Primes;

for my $n (0 .. 999) {
    print "n=$n" if $n % 50 == 0;
    next unless $n =~ /[1379]$/;
    my $s = sprintf '%03d', $n;
    for my $i (1 .. 3) {
        my @v = vary($s,$i);
        for my $v (@v) {
            my @p =
                grep { is_prime($_) }
                map {
                    (my $tmp = $v) =~ s/X/$_/g;
                    $tmp;
                } 0 .. 9;
            next unless @p >= 7;
            print "$v => @p";
        }
    }
}

sub vary {
    my ($s, $n) = @_;
    return ($s) if $n == 0;
    my %out;
    for my $v (vary($s,$n-1)) {
        map {
            my $tmp = $v;
            substr($tmp,$_,0,'X');
            $out{ $tmp } = 1;
        } 0 .. length($v)-1;
    }
    return sort keys %out;
}

