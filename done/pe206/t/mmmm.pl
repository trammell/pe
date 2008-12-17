#!/usr/bin/perl -l

use strict;
use warnings;
use Math::BigInt;

my $MAX = 10_000;

my @cand;

for my $n (1000 .. 9999) {
    my $x = square([$n]);
    my $y = as_string(@$x);
    next unless $y =~ /9.0$/;
    #print "$n => $y";
    push @cand, [$n];
}

my @tmp;

for my $c (@cand) {
    for my $i (1000 .. 9999) {
        my $n = [ $i, @$c ];
        my $x = square($n);
        my $y = as_string(@$x);
        next unless $y =~ /7.8.9.0$/;
        #print "@$n => $y";
        push @tmp, $n;
    }
}

@cand = @tmp;
@tmp = ();

for my $c (@cand) {
    for my $i (1000 .. 9999) {
        my $n = [ $i, @$c ];
        my $x = square($n);
        my $y = as_string(@$x);
        next unless $y =~ /5.6.7.8.9.0$/;
        push @tmp, $n;
    }
}

@cand = @tmp;
@tmp = ();

print "@$_" for @cand;

sub square {
    my @x = reverse @{ $_[0] };
    my @y = (0);

    for my $i (0 .. $#x) {
        next unless $x[$i];
        $y[$i]     += $x[$i] * $x[$i];
        $y[$i + 1]  = int( $y[$i] / $MAX );
        $y[$i]      = $y[$i] % $MAX;
    }

    while (1) {
        last if @y == 1;
        last if $y[-1];
        pop @y;
    }

    return [ reverse @y ];
}

sub as_string {
    my $s = join q(), map { sprintf('%04d',$_) } @_;
    $s =~ s/^0*(.)/$1/;
    return $s;
}

