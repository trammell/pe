#!/usr/bin/perl -l

package PCF;

use strict;
use warnings FATAL => 'all';
use base 'Exporter';
use Data::Dumper;
use Primes;

our @EXPORT_OK = 'pcf';

unless (caller()) {
    my @correct = (0,0,1,2,2,3,3,4,4,4,4,5,5,6,6,6,6,7,7,8,8,8,8);
    for my $i (0 .. $#correct) {
        my $c = $correct[$i];
        my $pcf = pcf($i);
        if ($c == $pcf) {
            warn "pcf($i)=$pcf\n";
        }
        else {
            warn "got pcf($i)=$pcf; should be $c\n";
        }
    }
}

my @PCF;

sub pcf {
    my $n = shift;
    unless (@PCF) {
        @PCF = (0, 0, 1, 2, 2);
    }
    while ($n > $#PCF) {
        my $i = $#PCF;
        push @PCF, $PCF[$i] + (is_prime($i + 1) ? 1 : 0);
    }
    return $PCF[$n];
}

1;

=pod

The prime counting function is the function pi(x) giving the number of
primes less than or equal to a given number x.

http://mathworld.wolfram.com/PrimeCountingFunction.html
http://www.research.att.com/~njas/sequences/A000720

=cut

