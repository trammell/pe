#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=70 :

use strict;
use warnings;
use Sieve;

my @p = Sieve->primes;

# calculate a "running sum" of primes @rs, such that $rs[$n] is the
# sum of $p[$i] where $i <= $n:

my @rs = (0);
for my $i (1 .. $#p) {
    $rs[$i] = $p[$i-1] + $rs[$i - 1];
}

print "\@rs = @rs[0..19] ...";

my $record = 0;     # the largest prime we've found
my $nterms = 0;     # the number of terms summed to find $record
my $max    = 1_000_000;   # the largest prime we're interested in

RS:
for my $i (0 .. $#rs) {
    next RS if $rs[$i] - $rs[$i - $nterms - 1] > $max;
    for (my $j=0; $j <= $i - $nterms - 1; $j++) {
        my $sum = $rs[$i] - $rs[$j];
        next if $sum > 1_000_000;
        next unless Sieve->is_prime($sum);
        $record = $sum;
        $nterms = $i - $j;
        print "new record: prime=$record, $nterms terms";
        next RS;
    }
}

print "final record: prime=$record, $nterms terms";

__END__

The prime 41, can be written as the sum of six consecutive primes:

    41 = 2 + 3 + 5 + 7 + 11 + 13

This is the longest sum of consecutive primes that adds to a prime
below one-hundred.

The longest sum of consecutive primes below one-thousand that adds to
a prime, contains 21 terms, and is equal to 953.

Which prime, below one-million, can be written as the sum of the most
consecutive primes?

