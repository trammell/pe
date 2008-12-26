package Primes;

use strict;
use warnings FATAL => 'all';
use base 'Exporter';

our @PRIMES;
require PrimeList;
my $MAX = $PRIMES[-1];
our @EXPORT = qw( primes is_prime );

sub primes {
    return @PRIMES;
}

sub max_prime {
    return $MAX;
}

unless (caller()) {
    print "primes are: @PRIMES[0 .. 9] ... $MAX\n";
}

my $lookup;
sub is_prime {
    my $n = shift;
    $lookup ||= { map { $_ => 1 } primes() };
    if ($n <= 1_000_000) {
        return $lookup->{ $n };
    }

    my $s = 1 + int(sqrt($n));
    if ($s <= 1_000_000) {
        for (my $i=0; $PRIMES[$i] < $s; $i++) {
            return 0 if $n % $PRIMES[$i] == 0;
        }
        return 1;
    }

    die "is_prime(n=$n) out of range";
}

1;

