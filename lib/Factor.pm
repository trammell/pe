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

=head2 pf($n)

Returns the full prime factorization of C<$n>, in the form of a hash whose
keys are primes, and corresponding values are the multiplicity of those
primes.

=cut

sub pf {
    my $n = shift;
    my %pf;
    my @primes = primes();
    while (@primes && $n > 1) {
        my $p = shift @primes;
        next unless $n % $p == 0;
        while ($n % $p == 0) {
            $pf{$p}++;
            $n /= $p;
        }
    }
    return %pf;
}

1;

