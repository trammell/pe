#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

package ConFrac;

use strict;
use warnings FATAL => 'all';
use Math::BigInt;
use Math::BigFloat;

Math::BigFloat->accuracy(100);

unless (caller()) {
    my @a = cf(sqrt(2.0),10);
    print "@a";
    @a = cf(sqrt(3.0),10);
    print "@a";
    @a = cf(sqrt(4.0),10);
    print "@a";

    my $PI = 4 * atan2(1,1);
    my $it = make_iterator($PI);
    for (1 .. 10) {
        my ($a,$n,$d,undef) = $it->();
        my $f = Math::BigFloat->new($n) / Math::BigFloat->new($d);
        print "$n / $d => $f";
    }
}

sub cf {
    my ($x, $niter) = @_;
    my @a;
    my $EPSILON = 1e-10;
    while ($niter--) {
        push @a, int($x);
        $x -= int($x);
        if ($x < $EPSILON) {
            warn "cf(): x too small, returning\n";
            return @a;
        }
        $x = 1.0 / $x;
    }
    return @a;
}

sub convergents {
    my @a = shift;

    #if @a < 2 ...

    my @num;
    my @den;

    $num[0] = $a[0];
    $den[0] = 1;

    $num[1] = $a[1] * $a[0] + 1;
    $den[1] = $a[1];

    for my $n (2 .. $#a) {
        $num[$n] = $a[$n] * $num[$n - 1] + $num[$n - 2];
        $den[$n] = $a[$n] * $den[$n - 1] + $den[$n - 2];
    }

    return map [ $num[$_], $den[$_] ], 0 .. $#num;

}

sub make_iterator {
    my $float = Math::BigFloat->new("$_[0]");
    my @a;
    my @num;
    my @den;
    my $EPSILON = 1e-10;

    return sub {
        my $a = $float->copy->bfloor();
        push @a, Math::BigInt->new($a);
        $float->bsub($a);
        if ($float < $EPSILON) {
            warn "cf(): float too small, returning\n";
            return undef;
        }
        else {
            $float = 1.0 / $float;
        }

        if ($#a == 0) {
            $num[0] = $a[0];
            $den[0] = 1;
        }
        elsif ($#a == 1) {
            $num[1] = $a[1] * $a[0] + 1;
            $den[1] = $a[1];
        }
        else {
            push @num, $a[-1] * $num[-1] + $num[-2];
            push @den, $a[-1] * $den[-1] + $den[-2];
        }

        return $a[-1], $num[-1], $den[-1], $float->copy;
    };
}

1;

