#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my %is_square = map { $_ * $_ => $_ } 1 .. 1000;

for my $i (2,3,5,6,7,8,10,11,12,13,23) {
    print "period(sqrt($i))=", find_period($i);
}

my $odd = 0;

for my $n (1 .. 10_000) {
    warn "n=$n odd=$odd\n" if $n % 100 == 0;
    if (my $sqrt = $is_square{$n}) {
        warn "skipping perfect square: sqrt($n)=$sqrt\n";
        next;
    }
    $odd++ if find_period($n) % 2 == 1;
}

print "count of numbers with odd period: $odd";

sub find_period {
    my $s = sqrt($_[0]);
    my $a0 = int($s);
    $s = 1.0 / ($s - $a0);
    my $p = 0;
    while (1) {
        $p++;
        last if int($s) == 2 * $a0;
        $s = 1.0 / ($s - int($s));
    }
    return $p;
}

