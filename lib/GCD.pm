package GCD;

use strict;
use warnings FATAL => 'all';
use base 'Exporter';

our @EXPORT = 'gcd';

sub gcd {
    my ($a,$b) = @_;
    return $b ? gcd($b, $a % $b) : $a;
}

1;

