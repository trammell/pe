#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;
use Cubes;

my %seen;
my $count = 0;

for my $i (102_345 .. 456_789) {
    print "i=$i" if $i % 5_000 == 0;
    my $d1 = merge($i);
    my $s1 = as_string($d1);
    next unless sides($d1) == 6;
    my $c = complement_of($d1);
    my ($r1, $r2) = mk_range($c);
    for my $j ($r1 .. $r2) {

        my $d2 = merge($c,$j);
        next unless sides($d2) == 6;
        my $s2 = as_string($d2);

        next if $seen{ $s1 }{ $s2 };
        next if $seen{ $s2 }{ $s1 };
        $seen{ $s1 }{ $s2 } = $seen{ $s2 }{ $s1 } = 1;

        if (shows_all($d1,$d2)) {
            $count++;
            print "    $s1 $s2 count=$count";
        }
    }
}

print "final count=$count";

