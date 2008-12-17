#!/usr/bin/perl -l

package Sieve;

use strict;
use warnings;
use Data::Dumper;

my $MAX = 10_000_000;

my %primes;
my $sieve = q();
vec($sieve,0,1) = 1;
vec($sieve,1,1) = 1;
my $pos = 1;

$| = 1;

sub init {
    my $n = 0;

    while ($pos < $MAX) {
        $n++;

        # find the next unmarked position in the sieve
        my $found;
        for my $i ($pos + 1 .. $MAX) {
            next if vec($sieve,$i,1);
            $found++;
            $pos = $i;
            last;
        }

        # we couldn't find any, so we're done with the sieve
        last unless $found;

        # yay, we've found a prime!  Save it in the hash for easy access.
        #print "found prime at $pos";
        if ($n < 10 || $n % 10000 == 0) {
            print "found prime[$n] => $pos";
        }
        $primes{ $pos } = 1;

        # tag all multiples of the prime we found
        for (my $i = 2; $i * $pos <= $MAX; $i++) {
            vec($sieve,$i * $pos,1) = 1;
        }
    }
}

sub is_prime {
    return exists $primes{ $_[0] };
}

init();

1;

__END__



