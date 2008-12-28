#!/usr/bin/perl
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings FATAL => 'all';
use Test::More 'no_plan';

use_ok('Coins');

# from http://www.research.att.com/~njas/sequences/table?a=41&fmt=4

is(P(1,1),1);
is(P(1,2),2);
is(P(1,3),3);
is(P(1,4),5);
is(P(1,5),7);
is(P(1,6),11);
is(P(1,7),15);
is(P(1,8),22);
is(P(1,9),30);
is(P(1,10),42);
is(P(1,20),627);
is(P(1,30),5604);
is(P(1,100),569_292);   # P() mod 1e6

is(P(2,1),0);
is(P(2,2),1);
is(P(2,3),1);
is(P(2,4),2);
is(P(2,5),2);
is(P(2,6),4);
is(P(2,7),4);
is(P(2,8),7);
is(P(2,9),8);
is(P(2,10),12);

is(P(3,2),0);
is(P(3,3),1);
is(P(3,9),4);
is(P(3,10),5);
is(P(4,10),3);

is(P(3,12),9);
is(P(4,16),11);
is(P(5,20),13);
is(P(6,24),16);

