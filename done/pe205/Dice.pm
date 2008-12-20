#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use List::Util 'sum';

my @c;
my @p;

for my $i (6 .. 36) {
    print "c: i=$i";
    my $j = 42 - $i;
    next if $p[$i];
    my $p = F(6,6,$i);
    $c[$i] = $c[$j] = $p;
}

for my $i (9 .. 36) {
    print "p: i=$i";
    my $j = 45 - $i;
    next if $p[$i];
    my $p = F(4,9,$i);
    $p[$i] = $p[$j] = $p;
}

my $sump = 0;
my $sumc = 0;

for my $i (0 .. 40) {
    $c[$i] ||= 0.0;
    $p[$i] ||= 0.0;
    $sump += $p[$i];
    $sumc += $c[$i];
    print "i=$i";
    print "    c=$c[$i] sumc=$sumc";
    print "    p=$p[$i] sump=$sump";
}

my $sum = 0.0;

for my $i (1 .. 40) {
    print "i=$i sum=$sum";
    my $c = sum map { $c[$_] } 0 .. $i - 1;
    $sum += $p[$i] * $c;
}

printf "%.7f\n", $sum;

=head2 F($s,$i,$k)

Returns the probability of rolling a die with C<$s> sides C<$i> times, and
coming up with a total value of C<$k>.  E.g.:

    F(4,1,1) = 0.25
    F(4,2,1) = 0

    F(6,1,3) = 1/6
    F(6,2,3) = 2/36 = 0.55555

=cut

sub F {
    my $s = shift;  # number of sides
    my $i = shift;  # number of dice
    my $k = shift;  # desired sum
    if ($i == 1) {
        return 0 if $k < 1;
        return 0 if $k > $s;
        return 1.0 / $s;
    }
    my $sum = 0;
    for my $n (0 .. $s) {
        $sum += F($s,1,$n) * F($s,$i-1,$k-$n)
    }
    return $sum;
}

__END__

http://projecteuler.net/index.php?section=problems&id=205

Problem 205
06 September 2008

Peter has nine four-sided (pyramidal) dice, each with faces numbered 1, 2,
3, 4.  Colin has six six-sided (cubic) dice, each with faces numbered 1, 2,
3, 4, 5, 6.

Peter and Colin roll their dice and compare totals: the highest total wins.
The result is a draw if the totals are equal.

What is the probability that Pyramidal Pete beats Cubic Colin? Give your
answer rounded to seven decimal places in the form "0.abcdefg".

