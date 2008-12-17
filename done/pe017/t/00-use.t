
use Test::More 'no_plan';

use_ok('Numbers');

is(en(1),'one');
is(en(2),'two');
is(en(3),'three');
is(en(4),'four');
is(en(5),'five');
is(en(15),'fifteen');
is(en(24),'twenty-four');
is(en(42),'forty-two');
is(en(100),'one hundred');
is(en(115),'one hundred and fifteen');
is(en(204),'two hundred and four');
is(en(342),'three hundred and forty-two');
is(en(508),'five hundred and eight');
is(en(600),'six hundred');
is(en(703),'seven hundred and three');
is(en(999),'nine hundred and ninety-nine');

