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
        warn "skipping perfect square: $sqrt^2=$n\n";
        next;
    }
    $odd++ if find_period($n) % 2 == 1;
}

print "count of numbers with odd period: $odd";

my %per;

sub find_period {
    my $r = sqrt($_[0]);
    my @terms;
    my %seen;
    while (1) {
        my $t = next_term($r);
        return $per{ $t->[0] } if $per{ $t->[0] };
        push @terms, $t;
        last if $seen{ $t->[0] };
        $seen{ $t->[0] } = 1;
        $r = $t->[2];
    }
    my $s = pop(@terms)->[0];
    my $p = 0;
    for (reverse @terms) {
        $p++;
        last if $_->[0] eq $s;
    }
    $per{ $_->[0] } = $p for @terms;
    return $p;
}

my %nt;
sub next_term {
    my $x = shift;
    my $s = sprintf '%.9f', $x;
    $nt{$s} ||= do {
        my $a = int($x);
        my $f = 1.0 / ($x - $a);
        [ $s, $a, $f ];
    };
}
