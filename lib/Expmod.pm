package Expmod;

use strict;
use warnings FATAL => 'all';
use base 'Exporter';

our @EXPORT_OK = ('expmod');

=head2 expmod($a,$n,$m)

Returns C<< $a ^ $n (mod $m) >>.

See:

    http://mathworld.wolfram.com/Residue.html
    http://mathworld.wolfram.com/SuccessiveSquareMethod.html
    http://en.wikipedia.org/wiki/Modular_exponentiation

=cut

sub expmod {
    my ($a, $n, $m) = @_;
    my $b = 1;
    while ($n > 0) {
        if (($n & 1) == 1) {
            $b = ($b * $a) % $m;
        }
        $n >>= 1;
        $a = ($a * $a) % $m;
    }
    return $b;
}

1;

