#!/usr/bin/perl
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings FATAL => 'all';
use Test::More 'no_plan';

use_ok('Partition',qw/ nip p ip /);

# check our 'naive' solution
is(nip(1,1),1);
is(nip(2,1),2);
is(nip(3,1),3);
is(nip(4,1),5);
is(nip(5,1),7);
is(nip(6,1),11);
is(nip(7,1),15);
is(nip(8,1),22);
is(nip(9,1),30);
is(nip(10,1),42);

__END__

diag p(100);

# from http://www.research.att.com/~njas/sequences/table?a=41&fmt=4

is(p(1),1);
is(p(2),2);
is(p(3),3);
is(p(4),5);
is(p(5),7);
is(p(6),11);
is(p(7),15);
is(p(8),22);
is(p(9),30);
is(p(10),42);
is(p(20),627);
is(p(30),5604);
is(p(40),37338);

is(ip(2,1),0);
is(ip(2,2),1);
is(ip(2,3),1);
is(ip(2,4),2);
is(ip(2,5),2);
is(ip(2,6),4);
is(ip(2,7),4);
is(ip(2,8),7);
is(ip(2,9),8);
is(ip(2,10),12);

is(ip(3,2),0);
is(ip(3,3),1);
is(ip(3,9),4);
is(ip(3,10),5);
is(ip(4,10),3);

is(ip(3,12),9);
is(ip(4,16),11);
is(ip(5,20),13);
is(ip(6,24),16);

