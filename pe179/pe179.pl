#!/usr/bin/env perl

use strict;
use warnings FATAL => 'all';
use Data::Dumper;
use Sieve;
use List::Util 'reduce';

my @PRIMES = Sieve::primes();
my $same = 0;
my $last = -1;

for my $n (1 .. 10_000_000) {
    my $d = divisors($n);
    warn "# d($n) = $d\n" if $n % 5000 == 0;
    if ($last == $d) {
        $same++;
    }
    $last = $d;
}

print "same=$same\n";

sub divisors {
    my $n = shift;
    return 1 if $n == 1;
    my %pf = pf($n);
    my @foo = map { $_ + 1 } values %pf;
    no warnings 'once';
    return reduce { $a * $b } 1, @foo;
}

=head2 pf($n)

Returns the full prime factorization of C<$n>, in the form of a hash whose
keys are primes, and corresponding values are the multiplicity of those
primes.

=cut

sub pf {
    my $n = shift;
    my %pf;
    my $i = 0;
    while ($n > 1 && $i < @PRIMES) {
        my $p = $PRIMES[$i];
        while ($n % $p == 0) {
            $pf{$p}++;
            $n /= $p;
        }
        $i++;
    }
    return %pf;
}

__END__

http://projecteuler.net/index.php?section=problems&id=179

Problem 179
26 January 2008

Find the number of integers 1 < n < 10^7, for which n and n+1 have the same
number of positive divisors. For example, 14 has the positive divisors 1,
2, 7, 14 while 15 has 1, 3, 5, 15.

