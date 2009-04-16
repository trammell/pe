#!/usr/bin/perl
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings FATAL => 'all';
use Test::More 'no_plan';

use_ok('Partition','Pt');

# from http://www.research.att.com/~njas/sequences/table?a=41&fmt=4

is(Pt(1,1),1);
is(Pt(1,2),2);
is(Pt(1,3),3);
is(Pt(1,4),5);
is(Pt(1,5),7);
is(Pt(1,6),11);
is(Pt(1,7),15);
is(Pt(1,8),22);
is(Pt(1,9),30);
is(Pt(1,10),42);
is(Pt(1,20),627);
is(Pt(1,30),5604);
is(Pt(1,100),569_292);  # NOTE: Pt() is P() mod 1e6

is(Pt(2,1),0);
is(Pt(2,2),1);
is(Pt(2,3),1);
is(Pt(2,4),2);
is(Pt(2,5),2);
is(Pt(2,6),4);
is(Pt(2,7),4);
is(Pt(2,8),7);
is(Pt(2,9),8);
is(Pt(2,10),12);

is(Pt(3,2),0);
is(Pt(3,3),1);
is(Pt(3,9),4);
is(Pt(3,10),5);
is(Pt(4,10),3);

is(Pt(3,12),9);
is(Pt(4,16),11);
is(Pt(5,20),13);
is(Pt(6,24),16);

