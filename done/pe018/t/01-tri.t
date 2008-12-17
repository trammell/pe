use strict;
use warnings;

use Data::Dumper;
use Test::More 'no_plan';

use_ok('Tri','T');

is( T(0,0), 75 );
is( T(1,0), 95 );
is( T(1,1), 64 );

#warn Dumper($Tri::T);
#warn Dumper($Tri::T->[0]);
#warn Dumper($Tri::T->[1][0]);
