
use Test::More 'no_plan';

use_ok('Totient');

$::DEBUG = 1;

is(phi(90),24);
is(phi(91),72);
is(phi(92),44);
is(phi(93),60);
is(phi(94),46);
is(phi(95),72);
is(phi(96),32);
is(phi(97),96);
is(phi(98),42);
is(phi(99),60);
is(phi(87109),79180);

