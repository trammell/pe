use strict;
use warnings;

use Data::Dumper;
use Test::More 'no_plan';

use_ok('Lychrel','is_lychrel','L');

is(L(5),10);
is(L(10),11);
is(L(56),121);
is(L(57),132);
is(L(132),363);

for (1 .. 100) {
    ok(! is_lychrel($_)) or diag "$_ should not be Lychrel";
}

ok(is_lychrel(196));

