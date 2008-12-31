
package Totient;

use strict;
use warnings;
use base 'Exporter';
use Primes;
use List::Util 'reduce';

our $DEBUG;
our @EXPORT_OK = 'Phi';

my @primes = primes();

my $maxprime = $primes[-1];

unless (caller()) {
    for (1 .. 20) {
        print "Phi($_)=", Phi($_),"\n";
    }
}

my $PHI;
sub Phi {
    my $n = shift;
    $PHI ||= [1,1,1,2,2,4,2];
    $PHI->[$n] ||= int(_phi($n) + 0.1);
}

sub _phi {
    my $n = $_[0];
    return $n - 1 if $n < $maxprime && is_prime($n);
    for (my $i=0;;$i++) {
        my $p = $primes[$i];
        last if $p * $p > $n;
        next unless $n % $p == 0;
        my $k = 0;
        while ($n % $p == 0) {
            $n /= $p;
            $k++;
        }
        warn "$_[0] => $p^$k * $n" if $DEBUG;
        return ($p - 1) * $p ** ($k - 1) * Phi($n);
    }
    return $n - 1;
}

1;

