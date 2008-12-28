#!/usr/bin/perl -l

use strict;
use warnings;
use Test::More 'no_plan';

use_ok('Prime','is_prime');

ok(is_prime(2));
ok(!is_prime(100));
ok(is_prime(99991));
ok(!is_prime(100001));
ok(is_prime(131071));      # 2^17 - 1
ok(is_prime(524287));      # 2^19 - 1

