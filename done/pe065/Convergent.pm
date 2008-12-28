#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Math::BigInt;
use List::Util 'sum';

my @a = map a($_), 0 .. 10;
print "@a";

sub b {
    return Math::BigInt->new("$_[0]");
}

my @n = (b(2),b(3));
my @d = (b(1),b(1));

for my $i (2 .. 100) {
    $n[$i] = a($i) * $n[$i - 1] + $n[$i - 2];
    $d[$i] = a($i) * $d[$i - 1] + $d[$i - 2];
    print "i=$i => $n[$i] / $d[$i]" if $i % 10 == 0;
}

my $n = $n[99];

print sum split //, $n->bstr;


sub a {
    my $i = shift;
    return 2 if $i == 0;
    return 1 if $i % 3 == 0;
    return 1 if $i % 3 == 1;
    return int(($i + 1) * .667);
}

__END__

http://projecteuler.net/index.php?section=problems&id=65

Problem 65
12 March 2004

The square root of 2 can be written as an infinite continued fraction.

                   1
    2 = 1 + -----------------
                     1
            2 + -------------
                        1
                2 + ---------
         
                     2 + ...

The infinite continued fraction can be written, 2 = [1;(2)], (2) indicates
that 2 repeats ad infinitum. In a similar way, 23 = [4;(1,3,1,8)].

It turns out that the sequence of partial values of continued fractions for
square roots provide the best rational approximations. Let us consider the
convergents for 2.

    1 + 1/2 = 3/2
    
           1
    1 + ------- = 7/5
        2 + 1/2

            1
    1 + ----------- = 17/12
               1
        2 + -------
            2 + 1/2

    ...

Hence the sequence of the first ten convergents for 2 are:

    1, 3/2, 7/5, 17/12, 41/29, 99/70, 239/169, 577/408, 1393/985,
    3363/2378, ...

What is most surprising is that the important mathematical constant,

    e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].

The first ten terms in the sequence of convergents for e are:

    2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...

The sum of digits in the numerator of the 10th convergent is 1+4+5+7=17.

Find the sum of digits in the numerator of the 100th convergent of the
continued fraction for e.

Analysis:

    e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].
    n    0  1 2 3  4 5 6  7 8 9
    k         1      2      3

