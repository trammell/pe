
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

sub Pt {
    my ($k,$n) = @_;

    # boundary conditions
    return 0 if $n < 0;
    return 0 if $k < 0;
    return 0 if $k > $n;
    return 1 if $k == $n;

    # preemptively calculate Pt($i,$n) for $k <= $i <= $n + 1
    my $lattice = sub { 5 * (1 + int($_[0]/5)) };
    unless (exists $Pt->{ $lattice->($k) }{ $lattice->($n)} ) {
        init($n);
    }

    unless (exists $Pt->{$k}{$n}) {
        if (($k % 10 == 0) && ($n % 10 == 0)) {
            print "calculating Pt(k=$k,n=$n) ...";
        }
        my $p1 = Pt($k + 1, $n);
        my $p2 = Pt($k, $n - $k);
        $Pt->{$k}{$n} = ($p1 + $p2) % $TRUNC;
    }
    return $Pt->{$k}{$n};
}

sub init {
    my $max = shift;
    my $incr = 5;
    for (my $n = $incr; $n <= $max; $n += $incr) {
        for (my $k = $incr; $k <= $n; $k += $incr) {
            next if exists $Pt->{$k}{$n};
            print "initializing Pt($k,$n)...";
            Pt($k,$n);
        }
    }
}

1;

