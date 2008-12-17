#!/usr/bin/perl -l

package Ami;

use strict;
use warnings;
use base 'Exporter';
use List::Util 'sum';

our @EXPORT_OK = qw(is_amicable);

my %D;

sub d {
    my $n = shift;
    return 0 if $n < 2;
    $D{$n} ||= do {
        sum grep { $n % $_ == 0 } 1 .. $n - 1;
    };
}

sub is_amicable {
    my $n = shift;
    return 0 if $n < 2;
    my $d = d($n);
    if ($d != $n) {
        return 1 if d(d($n)) == $n;
    }
    return 0;
}

unless (caller()) {
    my $sum = 0;
    for (1 .. 10000) {
        next unless is_amicable($_);
        print "amicable: $_";
        $sum += $_;
    }
    print "sum: $sum";
}

__END__

Let d(n) be defined as the sum of proper divisors of n (numbers less than n
which divide evenly into n).

If d(a) = b and d(b) = a, where a != b, then a and b are an amicable pair and
each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55
and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and
142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.

