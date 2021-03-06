#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;

my $min = 999_999_999;
for (my $j=1; 1; $j++) {
    print "at j=$j..." if $j % 1000 == 0;
    for my $k (1 .. $j-1) {
        my $x = P($j);
        my $y = P($k);
        next unless is_pentagonal($x+$y);
        my $a = abs($x - $y);
        next unless $a < $min;
        next unless is_pentagonal($a);
        $min = $a;
        print "new minimum: $min";
    }
}
print "min=$min";

sub P {
    return $_[0] * (3 * $_[0] - 1) / 2;
}

my @cache;

sub is_pentagonal {
    $cache[ $_[0] ] ||= do {
        my $n = (1 + sqrt(24 * $_[0] + 1)) / 6;
        (abs(int($n) - $n) < 1e-9) ? 'true' : 'false';
    };
    return ($cache[ $_[0] ] eq 'true') ? 1 : 0;
}

1;

__END__

Pentagonal numbers are generated by the formula, Pn=n(3n-1)/2. The first ten
pentagonal numbers are:

    1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...

It can be seen that P(4) + P(7) = 22 + 70 = 92 = P(8). However, their
difference, 70 - 22 = 48, is not pentagonal.

Find the pair of pentagonal numbers, P(j) and P(k), for which their sum and
difference is pentagonal and D = |P(k)-P(j)| is minimised; what is the value of
D?

