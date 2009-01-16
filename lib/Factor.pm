package Foo;

use strict;
use warnings FATAL => 'all';
use Primes;

my @primes = primes();

unless (caller()) {
    my @f = factor(1234567); print "@f\n";
    @f = factor(128); print "@f\n";
}

sub factor {
    my $n = shift;
    my @f;

    for (my $i=0;;$i++) {
        last if $n == 1;
        my $p = $primes[$i];
        #last if $p * $p > $n;
        next unless $n % $p == 0;
        while ($n % $p == 0) {
            push @f, $p;
            $n /= $p;
        }
    }

    return @f;
}

1;

