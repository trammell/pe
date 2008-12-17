use strict;
use warnings;

#use Data::Dumper;
use Test::More 'no_plan';
use Ami 'is_amicable';

ok(!is_amicable(1));
ok(!is_amicable(2));
ok(!is_amicable(3));
ok(!is_amicable(5));

ok(is_amicable(220));
ok(is_amicable(284));

is(Ami::d(220),284);
is(Ami::d(284),220);

