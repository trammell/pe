#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use List::Util 'sum';

my $LIMIT = 1e8;
my $maxi = int(1 + sqrt($LIMIT / 2));

my %square = map { $_ => $_ * $_ } 1 .. $maxi;

my @pal;

for my $i (1 .. $maxi) {
    print "i=$i of $maxi" if $i % 100 == 0;

    for (my $n=$i*$i, my $j=$i + 1; $j < $maxi; $j++) {
        #print "$n += $square{$j}";
        $n += $square{ $j };
        if ($n <= $LIMIT && "$n" eq reverse("$n")) {
            print "   sumsq($i,$j)=$n";
            push @pal, $n;
            @pal = sort { $a <=> $b } @pal;
        }
    }

}

print "n=@{[ scalar @pal ]} sum=", sum @pal;

