# $Id:$
# $Source:$

use strict;
use warnings;
use Data::Dumper;
use Test::More 'no_plan';
use_ok('Monopoly');

# test die size == 6
my $m = Monopoly->new;
$m->die_size(6);

for (1 .. 1000) {
    my $t = $m->throw;
    ok($t <= 12);
    ok($t >= 2);
}

