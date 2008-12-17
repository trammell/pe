use strict;
use warnings;

#use Data::Dumper;
use Test::More 'no_plan';

use_ok('Part100');

is(nways(-1),0); # ?
is(nways(0),0); # ?

is(nways(1),1); # 1
is(nways(2),1); # 1+1
is(nways(3),2); # 2+1, 1+1+1
is(nways(4),4); # 3+1, 2+2, 2+1+1, 1+1+1+1
is(nways(5),6); # 4+1, 3+(2), 2+(3)

