#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my %is_square = map { $_ * $_ => $_ } 1 .. 100;

print Dumper(make_cf(sqrt(2)));
for my $i (2,3,5,6,7,8,10,11,12,13,23) {
    print "period(sqrt($i))=", find_period($i);
}
exit;

my $odd = 0;

for my $n (1 .. 10_000) {
    warn "n=$n odd=$odd\n" if $n % 50 == 0;
    if (my $sqrt = $is_square{$n}) {
        warn "skipping perfect square: sqrt($n)=$sqrt\n";
        next;
    }
    #my $p = find_period($n);
    #$odd++ if $p % 2 == 1;
}

print "count of numbers with odd period: $odd";

sub find_period {
    my $n = shift;
    my $s = sqrt($n);
    warn "$n:\n";
    my @a = make_cf($s);
    my $key = pop(@a)->[2];
    my $period = 0;
    for my $a (reverse @a) {
        $period++;
        last if $a->[2] eq $key;
    }
    return $period;
}

sub make_cf {
    my $x = shift;
    my @a;
    my %seen;
    while (1) {
        my $i = int($x);
        $x = $x - $i;
        my $key = sprintf "%d %.9f", $i, $x;
        push @a, [ $i, $x, $key ];
        last if $seen{$key};
        $seen{$key} = 1;
        $x = 1.0 / $x;
    }
    return @a;
}

