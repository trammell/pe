#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Sieve;

my @p = Sieve->primes;

my $i = 0;

I:
for my $i (1 .. 500_000) {
	$i++;
    print "$i..." unless $i % 1000;
    for my $j (0 .. 3) {
        next I if ndpf($i+$j) != 4;
    }
    print $i;
    last;
}

my %ncache;
sub ndpf {
    my $n = shift;
    $ncache{$n} ||= do {
        my %pf = map { $_,1 } @{ pf($n) };
        scalar(keys %pf);
    };
}

# return the number of prime factors
my %cache;
sub pf {
    my $n = shift;
    return 1 if $n == 1;
    $cache{ $n } ||= _pf($n);
}

sub _pf {
    my $n = shift;
    return [$n] if Sieve->is_prime($n);
    for (my $i = 0; $p[$i] < $n; $i++) {
        if ($n % $p[$i] == 0) {
            my $f = $n / $p[$i];
            return [ sort { $a <=> $b } $p[$i], @{pf($f)} ];
        }
    }
    return [];
}

