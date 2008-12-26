#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use lib "$ENV{HOME}/work/project-euler/lib";
use Primes;
use Data::Dumper;
use List::Util 'reduce';

my $MAX = 100_000;
my @primes = grep { $_ < 10_000 } primes();
my @rad;

for my $i (1 .. 100_000) {
    my $r = rad($i);
    print "i=$i r=$r" if $i % 5000 == 0;
    push @rad, [ $i, $r ];
}

@rad = sort {
    $a->[1] <=> $b->[1]
        ||
    $a->[0] <=> $b->[0]
} @rad;


print Dumper([@rad[0..19]]);

print "@{$rad[9999]}";
print "@{$rad[10_000]}";
print "@{$rad[10_001]}";

sub rad {
    my $n = shift;
    return 1 if $n == 1;
    return $n if is_prime($n);
    for my $p (@primes) {
        if ($n % $p == 0) {
            while ($n % $p == 0) { $n /= $p }
            return $p * rad($n);
        }
    }
}

