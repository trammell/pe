# $Id:$
# $Source:$

use strict;
use warnings;
use Data::Dumper;
use Test::More 'no_plan';
use List::Util 'sum';
use_ok('Monopoly');

# test die size == 6
{
    my $m = Monopoly->new;
    $m->die_size(6);

    my $d = 0;
    for (1 .. 1000) {
        my @t = $m->throw;
        ok(1 <= $_ && $_ <= 6) for @t;
        $d++ if $t[0] == $t[1];
        my $s = sum @t;
        ok(2 <= $s && $s <= 12);
    }
    ok(100 < $d && $d < 234);
}


# test die size == 6
{
    my $m = Monopoly->new;
    $m->die_size(4);
    my $d = 0;
    for (1 .. 1000) {
        my @t = $m->throw;
        ok(1 <= $_ && $_ <= 4) for @t;
        $d++ if $t[0] == $t[1];
        my $s = sum @t;
        ok(2 <= $s && $s <= 8);
    }
    ok(180 < $d && $d < 320);
}
