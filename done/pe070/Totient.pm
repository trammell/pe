#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Sieve;
use List::Util 'reduce';

our $DEBUG;

my @primes = Sieve->primes();

unless (caller()) {
    for (1 .. 20) {
        print "phi($_)=", phi($_);
    }
}

my $PHI;
sub phi {
    my $n = shift;
    $PHI ||= [1,1,1,2,2,4,2];
    $PHI->[$n] ||= int(_phi($n) + 0.1);
}

sub _phi {
    my $n = $_[0];
    return $n - 1 if $n < Sieve->max_prime && Sieve->is_prime($n);
    for (my $i=0;;$i++) {
        my $p = $primes[$i];
        last if $p * $p > $n;
        next unless $n % $p == 0;
        my $k = 0;
        while ($n % $p == 0) {
            $n /= $p;
            $k++;
        }
        warn "$_[0] => $p^$k * $n" if $DEBUG;
        return ($p - 1) * $p ** ($k - 1) * phi($n);
    }
    return $n - 1;
}

1;

