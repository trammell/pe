#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

my @F = map { factorial($_) } 0 .. 10;

unless (caller()) {
    my $iter = lp_iter();
    for (1 .. 1_000_002) {
        my @d = $iter->();
        if ($_ <= 10 || $_ > 999_997) {
            print "$_ => @d";
        }
        else {
            print "$_ ..." if $_ % 5000 == 0;
        }
    }
    
#   warn Dumper(\@F);

#   my @d = (0 .. 9);
#   my $n = 1_000_000;
#   my $i = 9;
#   while ($n > 0) {
#       print "N is $n, I is $i:";
#       my $j = int($n / $F[$i]);
#       print  "    $i ($F[$i]!) => $j instances";
#       printf "    %d - %d * %d = %d\n", $n, $j, $F[$i], $n - $j * $F[$i];
#       print  "    (@d)[$j] => next digit is $d[$j]";
#       $n -= $j * $F[$i];
#       delete $d[$j];
#       @d = grep defined, @d;
#       $i--;

#       my $f = fac($i);
#       {
#           if ($n >= $f) {
#           my $x = $n;
#           $n -= $f;
#           print "$x => $n ($i! = $f)"
#       }
#       $i--;
#    }
#
#   print "remaining digits: @d";
}

sub factorial {
    my $n = shift;
    return 1 if $n == 0 || $n == 1;
    return $n * factorial($n - 1);
}

# generates lexicographic permutations...
sub lp_iter {
    my @d = (0 .. 9);
    my $N = 10;

    return sub {
        my $i = $N - 1;
        while ($d[$i - 1] >= $d[$i]) {
            $i--;
        }

        my $j = $N;

        while ($d[$j - 1] <= $d[$i - 1]) {
            $j--;
        }

        # swap values at positions (i-1) and (j-1)
        @d[$i-1,$j-1] = @d[$j-1, $i-1];

        $i++;
        $j = $N;

        while ($i < $j) {
            @d[$i-1,$j-1] = @d[$j-1, $i-1];
            $i++;
            $j--;
        }
        return @d;
    };
}

1;

__END__

A permutation is an ordered arrangement of objects. For example, 3124 is one
possible permutation of the digits 1, 2, 3 and 4. If all of the permutations
are listed numerically or alphabetically, we call it lexicographic order. The
lexicographic permutations of 0, 1 and 2 are:

    012   021   102   120   201   210

What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5,
6, 7, 8 and 9?

Analysis:

    0! == 1
    1! == 1
    2! == 2
    3! == 6
    4! == 24
    5! == 120
    6! == 720
    7! == 5040
    8! == 40320
    9! == 362880
   10! == 3628800

    0.[123456789] => takes 362880 numbers, 637120 remaining
    1.[023456789] => takes 362880 numbers, 274240 remaining

    20.[13456789] =>  takes 40320 numbers, 233920 remaining
    21.[03456789] =>  takes 40320 numbers, 193600 remaining
    23.[01456789] =>  takes 40320 numbers, 153280 remaining
    24.[01356789] =>  takes 40320 numbers, 112960 remaining
    25.[01346789] =>  takes 40320 numbers,  72640 remaining
    26.[01345789] =>  takes 40320 numbers,  32320 remaining

    270.[1345689] =>   takes 5040 numbers,  27280 remaining
    271.[.......] =>   takes 5040 numbers,  22240 remaining
    273.[.......] =>   takes 5040 numbers,  17200 remaining
    274.[.......] =>   takes 5040 numbers,  12160 remaining
    275.[.......] =>   takes 5040 numbers,   7120 remaining
    276.[0134589] =>   takes 5040 numbers,   2080 remaining

    2780.[134569] =>    takes 720 numbers,   1360 remaining
    2781.[034569] =>    takes 720 numbers,    640 remaining

    27830.[14569] =>    takes 120 numbers,    420 remaining
    27831.[.....] =>    takes 120 numbers,    300 remaining
    27834.[.....] =>    takes 120 numbers,    180 remaining
    27835.[01469] =>    takes 120 numbers,     60 remaining

    278360.[1459] =>     takes 24 numbers,     36 remaining
    278361.[0459] =>     takes 24 numbers,     12 remaining

    2783640.[159] =>      takes 6 numbers,      6 remaining
    2783641.[059] =>      takes 6 numbers,      0 remaining

