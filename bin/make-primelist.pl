#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use lib "../lib/";
use Sieve max => 10_000_000;
use Text::Wrap;

$Text::Wrap::columns = 70;

my $sep = q( ) x 4;

print <<"__pkg__";
package Primes;

use strict;
use warnings FATAL => 'all';

our \@PRIMES = (
@{[ Text::Wrap::wrap($sep,$sep,join q(, ), Sieve->primes()) ]}
);

unless (caller()) {
    print join(q(, ), \@PRIMES[0 .. 9]), "... \$PRIMES[-1]\\n";
}

1;
__pkg__

