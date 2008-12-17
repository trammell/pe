use strict;
use warnings;

#use Data::Dumper;
use Test::More 'no_plan';

use_ok('HiddenSquare');
use_ok('Matches');

# Find the unique positive integer whose square has the form
# 1_2_3_4_5_6_7_8_9_0, where each "_" is a single digit.

ok( matches('930') );
ok( matches('7181910') );
ok( matches('1121324151617181910') );
ok(!matches('91121324151617181910'), 'too many characters' );
ok(!matches('2121324151617181910'), 'wrong high digit' );
ok(!matches('1111324151617181910') );
ok(!matches('1121324151617181911'), 'wrong low digit' );

