#!/usr/bin/perl -l

use strict;
use warnings;

my $primes = [2,3,5,7,11];

while (scalar(@$primes) < 10001) {
    find_another_prime($primes);
}

print scalar @$primes;
print $primes->[-1];

sub find_another_prime {
    my $p = shift;
    my $cand = $p->[-1];
    while (1) {
        $cand += 2;
        if (is_prime($cand,$p)) {
            push @$p, $cand;
            return;
        }
    }
}

sub is_prime {
    my ($cand, $primes) = @_;
    foreach my $p (@$primes) {
        return 0 if $cand % $p == 0;
    }
    return 1;
}

