#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings FATAL => 'all';
use diagnostics;
use Data::Dumper;
use Math::Combinatorics;
use Sieve;

my @primes = grep { length($_) == 6 } Sieve->primes();
print "nprimes=", scalar @primes;
print join q( ), mk_patterns("abc");
print join q( ), mk_patterns("abcd");

my @best;

for my $i (0 .. $#primes) {
    my $p = $primes[$i];
    print "i=$i p=$p" if $i % 25 == 0;
    for my $re (mk_patterns($p)) {
        my @family = grep { /$re/ } @primes;
        if (@family > @best) {
            my $n = scalar @family;
            print "p=$p re=$re n=$n @family";
            @best = @family;
        }
    }
}

print "best: @best";

sub mk_patterns {
    my $str = shift;
    my @p;
    for my $c (combo(length($str))) {
        my @c = @$c;
        my @tmp = split //, $str;
        $tmp[ $c[0] ] = q{(.)};
        $tmp[ $_ ] = q{(?:\1)} for @c[ 1 .. $#c ];
        push @p, join(q(), @tmp);
    }
    return @p;
}

my $COMBO;
sub combo {
    my $n = shift;
    $COMBO->{$n} ||= do {
        my $d = [ 0 .. $n - 1 ];
        my @out;
        #for (1 .. $n - 1) {
        for (1 .. 2) {
            my $mc = Math::Combinatorics->new(count => $_, data => $d);
            while (my @c = $mc->next_combination) {
                push @out, [ sort { $a <=> $b } @c ];
            }
        }
        \@out;
    };
    return @{ $COMBO->{$n} };
}

__END__

http://projecteuler.net/index.php?section=problems&id=51

Problem 51
29 August 2003

By replacing the 1st digit of *57, it turns out that six of the possible
values: 157, 257, 457, 557, 757, and 857, are all prime.

By replacing the 3rd and 4th digits of 56**3 with the same digit, this
5-digit number is the first example having seven primes, yielding the
family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently
56003, being the first member of this family, is the smallest prime with
this property.

Find the smallest prime which, by replacing part of the number (not
necessarily adjacent digits) with the same digit, is part of an eight prime
value family.

