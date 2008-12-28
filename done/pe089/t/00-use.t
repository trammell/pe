
use strict;
use warnings;
use Test::More 'no_plan';

use_ok('Minrom','minrom');

is(minrom('I'),('I'));

is(minrom("MCCCCCCVI"),"MDCVI");

is(minrom("XXXXVIIII"),"XLIX");
is(minrom("XXXXIX"),"XLIX");
is(minrom("XLVIIII"),"XLIX");
is(minrom("XLIX"),"XLIX");

