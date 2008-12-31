#!/usr/bin/perl -l

package PCF;

use strict;
use warnings FATAL => 'all';
use Data::Dumper;
use Primes;

unless (caller()) {
    for my $i (1 .. 20) {
        print "pcf($i)=", pcf($i);
    }
}

sub pcf {



}

1;

=pod

The prime counting function is the function pi(x) giving the number of
primes less than or equal to a given number x.

=cut

