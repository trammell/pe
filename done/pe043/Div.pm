#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use List::Util 'sum';

our $DEBUG = 0;

my $sum = 0;

my @cand = M(17);
print "17: @cand";

@cand = extend(\@cand,[M(13)]);
@cand = extend(\@cand,[M(11)]);
@cand = extend(\@cand,[M(7)]);
@cand = extend(\@cand,[M(5)]);
@cand = extend(\@cand,[M(3)]);
@cand = extend(\@cand,[M(2)]);
@cand = extend(\@cand,[M(1)]);

print @cand;
print sum @cand;

sub extend {
    my ($cand, $ext) = @_;
    my @out;
    foreach my $c (@$cand) {
        foreach my $e (@$ext) {
            # two rightmost chars of $e equal 2 leftmost chars of $c
            next unless substr($e,1,2) eq substr($c,0,2);
            my $n = $e . substr($c,2);
            print "$e + $c => $n" if $DEBUG;
            push @out, $n;
        }
    }
    return sort grep { !/(\d).*\1/ } @out;
}

# M for "mille" (1000)
sub M {
    my $n = shift;
    my @out;
    for (my $i=$n; $i < 1000; $i += $n) {
        push @out, sprintf("%03d",$i);
    }
    return sort grep { !/(\d).*\1/ } @out;
}

__END__

http://projecteuler.net/index.php?section=problems&id=43

The number, 1406357289, is a 0 to 9 pandigital number because it is made up
of each of the digits 0 to 9 in some order, but it also has a rather
interesting sub-string divisibility property.

Let d[1] be the 1st digit, d[2] be the 2nd digit, and so on. In this way,
we note the following:

    * d[2]d[3]d[4]  = 406 is divisible by 2
    * d[3]d[4]d[5]  = 063 is divisible by 3
    * d[4]d[5]d[6]  = 635 is divisible by 5
    * d[5]d[6]d[7]  = 357 is divisible by 7
    * d[6]d[7]d[8]  = 572 is divisible by 11
    * d[7]d[8]d[9]  = 728 is divisible by 13
    * d[8]d[9]d[10] = 289 is divisible by 17

Find the sum of all 0 to 9 pandigital numbers with this property.

