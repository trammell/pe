#!/usr/bin/perl
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Test::More 'no_plan';

use_ok('Hand');

hand1:
{
    my $h1 = Hand->new(qw(5H 5C 6S 7S KD));  # pair of 5's
    ok($h1);
    ok($h1->onepair);
    warn $h1->as_string;

    my $h2 = Hand->new(qw(2C 3S 8S 8D TD));  # pair of 8's
    ok($h2);
    ok($h2->onepair);
    warn $h2->as_string;
}

#   Hand    Player 1            Player 2            Winner
#   1       5H 5C 6S 7S KD      2C 3S 8S 8D TD      Player 2
#           Pair of Fives       Pair of Eights




