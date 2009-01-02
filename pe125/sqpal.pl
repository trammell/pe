#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use List::Util 'sum';

my %square = map { $_ => $_ * $_ } 1 .. 12_000;

my @pal;

my $LIMIT = 10_000_000;
#my $LIMIT = 1000;
my $maxi = int(10 + sqrt($LIMIT));

for my $i (1 .. $maxi) {
    #print "i=$i pal=(@pal)" if $i % 10 == 0;

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

