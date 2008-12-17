use strict;
use warnings;

#use Data::Dumper;
use Test::More 'no_plan';

use_ok('Bouncy','is_increasing','is_decreasing','is_bouncy');

ok(is_increasing(134468));
ok(!is_decreasing(134468));
ok(!is_bouncy(134468));

ok(is_decreasing(66420));
ok(!is_increasing(66420));
ok(!is_bouncy(66420));

ok(is_bouncy(155349));
ok(!is_decreasing(155349));
ok(!is_increasing(155349));

