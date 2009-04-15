
package Partition;

use strict;
use warnings FATAL => 'all';
use base 'Exporter';

our @EXPORT_OK = qw( Pt );

=head1 FUNCTIONS

=head2 P($k,$n)

=cut
###
### my $P;
### sub P {
###     my ($k,$n) = @_;
###     return 0 if $n < 0 || $k < 0;
###     return 0 if $k > $n;
###     return 1 if $k == $n;
###     unless ($P->{$k}{$n}) {
###         for (my $i=$n+1; $i > 0; $i--) {
###             my $p1 = P($i + 1,$n);
###             my $p2 = P($i,$n-$i);
###             $P->{$i}{$n} = $p1 + $p2;
###         }
###     }
###     return $P->{$k}{$n};
### }

=head2 Pt($k,$n)

=cut


my $Pt;
my $TRUNC = 1_000_000;

our $in_setup = 0;

sub Pt {
    my ($k,$n) = @_;

    # boundary conditions
    return 0 if $n < 0;
    return 0 if $k < 0;
    return 0 if $k > $n;
    return 1 if $k == $n;

    unless (exists $Pt->{$k}{$n}) {

        unless ($in_setup) {
            # preemptively calculate the necessary predecessors to calculate Pt($k,$n)
            # for $k <= $i <= $n + 1
            setup($n);
        }

        if (($k % 100 == 0) && ($n % 100 == 0)) {
            warn "calculating Pt(k=$k,n=$n) ...\n";
        }
        my $p1 = Pt($k + 1, $n);
        my $p2 = Pt($k, $n - $k);
        $Pt->{$k}{$n} = ($p1 + $p2) % $TRUNC;
    }
    return $Pt->{$k}{$n};
}

my $last_setup = 0;

sub setup {
    return if $in_setup;
    local $in_setup = 1;
    my $max = shift;
    return if $max <= $last_setup;
    for (my $n = $last_setup; $n <= $max; $n++) {
        for my $k (reverse(1 .. $n)) {
            if (($k % 100 == 0) && ($n % 100 == 0)) {
                warn "initializing Pt($k,$n)...\n";
            }
            Pt($k,$n);
        }
    }
    $last_setup = $max;
}

1;

