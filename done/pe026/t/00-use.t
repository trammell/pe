use strict;
use warnings;
use Test::More 'no_plan';
use Data::Dumper;

use_ok('Cycle',qw(find_cycle cycle invert));

is(invert(2,2),'0.50');
is(invert(2,10),'0.5000000000');

is(invert(3,3),'0.333');
is(invert(3,10),'0.3333333333');

is(cycle('0.500'),0) or diag Dumper(cycle('0.500'));

is(invert(123,12),'0.00813008130081');
is(find_cycle(123),'00813');

