#!/usr/bin/perl -l
# vim: set encoding=utf-8 fileencoding=utf-8 :

package Pence;

use strict;
use warnings;
use Data::Dumper;
use base 'Exporter';
#no warnings "recursion";

our @EXPORT_OK = ('make_iter');

unless (caller()) {
    #my ($n,@coins) = (200 => 1,2,5,10,20,50,100,200);

    for my $n (1,2,5,10,20,50,75,100,125,150,175,200) {
        my @coins = (1,2,5,10,20,50,100,200);
        my $nways = nways($n,@coins);
        print "$n into (@coins): $nways";
    }

#   my ($n,@coins) = (3 => 1,2,5);
#   my $i = make_iter($n,@coins);
#   while (my @change = $i->()) {
#       print "@change";
#   }
    #print "@$_" for r(100,\@coins);
}

my %N;

sub nways {
    my $n = shift;
    my @coins = sort { $b <=> $a } grep { $_ <= $n } @_;
    my $m = join(q(.),$n,@coins);
    $N{ $m } ||= _nw($n,@coins);
}

sub _nw {
    my ($n, @coins) = @_;

    return 1 if $n == 0;
    return 0 if $n < 0;
    return 0 if @coins == 0;

    my $max = $coins[0];
    my @rest = @coins[ 1 .. $#coins ];

    return nways($n,@rest) + nways($n - $max,@coins)

#    my @c = reverse sort { $a <=> $b } grep { $_ <= $n } @$coins;
#    my $mc = $c[0];
#    my @cr = @c[ 1 .. $#c ];
#    return (
#        r($n, \@cr),
#        map( [ $mc, @$_ ], r($n - $mc, \@c) ),
#    );
#}


}


sub make_iter {
    my $n = shift;
    my @coins = sort { $b <=> $a } grep { $_ <= $n } @_;
    if ($n == 0) {
        my $entered;
        return sub {
            if ($entered++) {
                return ();
            }
            return [];
        };
    }
    if (@coins == 0) {
        return sub { () };
    }

    my $id = "I(${n}p in @coins)";
    warn "$id\n";
    my $max = $coins[0];
    my @rest = @coins[ 1 .. $#coins ];
    my $it1;
    my $it2;
    my @queue;

    return sub {
        return ([]) unless $n;
        return () unless @coins;
        while (1) {
            last if @queue;

            $it1 ||= make_iter($n,@rest);
            if (my @c = $it1->()) {
                push @queue, \@c;
                next;
            }

            $it2 ||= make_iter($n - $max, @coins);
            if (my @c = $it2->()) {
                push @queue, [ $max, \@c ];
                next;
            }
        }

        my $x = shift @queue;
        return @$x;
    };
}

1;

__END__

In England the currency is made up of pound (Lb) and pence (p) and there are
eight coins in general circulation:

    1p, 2p, 5p, 10p, 20p, 50p, Lb1 (100p) and Lb2 (200p).

It is possible to make £2 in the following way

    1 x Lb1 + 1 x 50p + 2 x 20p + 1 x 5p + 1 x 2p + 3 x 1

How many different ways can Lb2 be made using any number of coins?

Analysis:

    1,2,5,10,20 into 20 => 41 combinations


#sub r {
#    my ($n, $coins) = @_;
#    return ([]) if $n == 0;
#    return () if @$coins == 0;
#    my @c = reverse sort { $a <=> $b } grep { $_ <= $n } @$coins;
#    my $mc = $c[0];
#    my @cr = @c[ 1 .. $#c ];
#    return (
#        r($n, \@cr),
#        map( [ $mc, @$_ ], r($n - $mc, \@c) ),
#    );
#}

