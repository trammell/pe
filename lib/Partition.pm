package Partition;

use strict;
use warnings FATAL => 'all';
use base 'Exporter';

our @EXPORT_OK = qw/ nip p ip /;

=head1 FUNCTIONS

=head2 p($n)

Returns the number of partitions of C<$n>.

=cut

sub p {
    my $n = shift;
    return ip(1,$n);
}

=head2 nip($k,$n)

This is a naive implementation of the I<intermediate> partition function as
described in Wikipedia at
L<http://en.wikipedia.org/wiki/Partition_function_%28number_theory%29>.  It
returns the number of partitions of C<$n> using only natural numbers at least
as large as C<$k>.

=cut

sub nip {
    my ($n,$k) = @_;
    return 0 if $n < 0 || $k < 0;
    return 0 if $k > $n;
    return 1 if $k == $n;
    return nip($n,$k + 1) + nip($n-$k,$k);
}

=head2 ip($n,$k)

This is an implementation of the I<intermediate> partition function that uses
caching to improve performance.

=cut

my $IP;

sub ip {
    my ($n,$k) = @_;

    # logical conditions according to the function definition; don't bother
    # cacheing these
    return 0 if $n < 1;
    return 0 if $k < 1;
    return 0 if $k > $n;
    return 1 if $k == $n;
    return 1 if $n < 2 * $k;

    # return the cached answer if we already know it
    if ($IP->{$k}{$n}) {
        my $grid = 10;
        if ($n % $grid == 0 && $k % $grid == 0) {
            warn "# ip($k,$n) = $IP->{$k}{$n}\n";
        }
        return $IP->{$k}{$n};
    }

    # we have to calculate ip($k,$n)
    $IP->{$k}{$n} ||= do {
        for my $_n (1 .. $n) {
            next if $IP->{$_n}{$_n};
            for my $_k (reverse $k + 1 .. $_n) {
                ip($_k,$_n,1);
            }
        }
        my $p1 = ip($k + 1,$n);
        my $p2 = ($n >= 2 * $k) ? ip($k,$n-$k) : 0;
        $p1 + $p2 % 1_000_000;
    };
}

sub ip_calc {


}

1;

