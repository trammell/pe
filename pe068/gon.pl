#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Gon;

print is_magic([4,6,5],[3,2,1]);
print is_magic([4,6,5],[3,1,2]);

