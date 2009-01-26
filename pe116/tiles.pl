#!/usr/local/bin/perl
# $Id:$
# $Source:$

use strict;
use warnings FATAL => 'all';

### red   => 2
### green => 3
### blue  => 4

my @t = (1,1);

for (my $i=2; $i < 10; $i++) {
    $t[$i] = $t[$i - 1] + $t[$i - 2];
}

