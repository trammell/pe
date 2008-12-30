#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

check();

my $odd = 0;

for my $n (1 .. 10_000) {
    warn "n=$n odd=$odd\n" if $n % 100 == 0;
    $odd++ if period($n) % 2 == 1;
}

print "count of numbers with odd period: $odd";


=head2 period($n)

Returns the period of the continued fraction expansion of C<sqrt($n)>.
Uses cacheing; precomputes known periods.  If C<$n> is square, returns 0.

=cut

my $P;

sub period {
    my $n = shift;
    $P ||= init_period();
    unless (defined $P->[$n]) {
        $P->[$n] = find_period($n);
    }
    return $P->[$n];
}

=head2 init_period()

Returns an arrayref containing precomputed periods.  From
L<http://www.research.att.com/~njas/sequences/A003285>:

    Any string of five consecutive terms m^2 - 2 through m^2 + 2 for m>2 in
    the sequence has the corresponding period lengths 4,2,0,1,2.
    - Lekraj Beedassy (blekraj(AT)yahoo.com), Jul 17 2001

=cut

sub init_period {
    my @p = (0, 0, 1, 2, 0, 1, 2);    # 0, 1, 2, 3, 4, 5, 6
    for my $m2 (map { $_ * $_ } 3 .. 100) {
        $p[$m2 - 2] = 4;
        $p[$m2 - 1] = 2;
        $p[$m2]     = 0;    # perfect square
        $p[$m2 + 1] = 1;
        $p[$m2 + 2] = 2;
    }
    return \@p;
}


my %per;

sub find_period {
    my $r = sqrt($_[0]);
    my @terms;
    my %seen;
    while (1) {
        my $t = next_term($r);
        return $per{ $t->[0] } if $per{ $t->[0] };
        push @terms, $t;
        last if $seen{ $t->[0] };
        $seen{ $t->[0] } = 1;
        $r = $t->[2];
    }
    my $s = pop(@terms)->[0];
    my $p = 0;
    for (reverse @terms) {
        $p++;
        last if $_->[0] eq $s;
    }
    $per{ $_->[0] } = $p for @terms;
    return $p;
}

my %nt;
sub next_term {
    my $x = shift;
    my $s = sprintf '%.9f', $x;
    $nt{$s} ||= do {
        my $a = int($x);
        my $f = 1.0 / ($x - $a);
        [ $s, $a, $f ];
    };
}

sub check {
    my @correct = (
        0, 0, 1, 2, 0, 1, 2, 4, 2, 0, 1, 2, 2, 5, 4, 2, 0, 1, 2, 6, 2, 6,
        6, 4, 2, 0, 1, 2, 4, 5, 2, 8, 4, 4, 4, 2, 0, 1, 2, 2, 2, 3, 2, 10,
        8, 6, 12, 4, 2, 0, 1, 2, 6, 5, 6, 4, 2, 6, 7, 6, 4, 11, 4, 2, 0, 1,
    );
    for my $i (0 .. $#correct) {
        my $p = period($i);
        if ($p == $correct[$i]) {
            print "period(sqrt($i)) = $p";
            next;
        }
        die "got period(sqrt($i))=$p; correct value is $correct[$i]";
    }
}

