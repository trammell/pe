use strict;
use warnings;

#use Data::Dumper;
use Test::More 'no_plan';
use_ok('Gon');

ok(  is_magic([4,6,5],[3,2,1]) );
ok( !is_magic([4,6,5],[3,1,2]) );

