#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :
# An attempted solution to Project Euler problem 51.

use strict;
use warnings FATAL => 'all';
use lib "$ENV{HOME}/work/project-euler/lib";
use Data::Dumper;
use Math::Combinatorics;
use Sieve;

my @primes = grep { length($_) == 6 } Sieve->primes();
print "nprimes=", scalar @primes;

