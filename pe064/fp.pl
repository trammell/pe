#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';

my %is_square = map { $_ * $_ => 1 } 1 .. 100;
my $odd = 0;

for my $n (1 .. 10_000) {
    print "n=$n" if $n % 100 == 0;
    if ($is_square{$n}) {
        print "skipping square: $n";
    }
    #my $per = find_period($n);
    #$odd++ if $per % 2 == 1;
}

print "count of numbers with odd period: $odd";

sub find_period {
    my $n = shift;
    my $s = sqrt($n);

    while (1) {

    }
}

sub expand {
    my $n = shift;
    ...

}

