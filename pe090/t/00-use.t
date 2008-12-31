use strict;
use warnings;

use Data::Dumper;
use Test::More 'no_plan';

use_ok('Cubes');

my $d = merge(123);

#warn Dumper($d);

is(sides($d), 3);

$d = merge($d,4);
is(sides($d), 4);

$d = merge($d,4);
is(sides($d), 4);

is(as_string($d), "1234");

is(as_string(merge("111")),"1");

{
    my $d1 = merge("012368");
    my $d2 = merge("134589");
    ok(shows_all($d1,$d2));
}
