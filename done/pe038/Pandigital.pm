#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=70 :

use strict;
use warnings;

I:
for (my $i = 1; 1; $i++) {
    my $max = 0;
    my $c = q();
    N:
    for my $n (1 .. 9) {
        $c .= $i * $n;
        next N if length($c) < 9;
        next I if length($c) > 9;
        next I unless is_pandigital($c);
        print "found pandigital: i=$i n=$n c=$c";
        if ($c > $max) {
            $max = $c;
            print "found new max=$max";
        }
        next I;
    }
}

sub is_pandigital {
    my $s = join q(), @_;
    return 0 if length($s) != 9;
    return 0 if $s =~ /0/;
    return 0 if $s =~ /(\d).*\1/;
    return 1;
}

__END__

Take the number 192 and multiply it by each of 1, 2, and 3:

    192 x 1 = 192
    192 x 2 = 384
    192 x 3 = 576

By concatenating each product we get the 1 to 9 pandigital, 192384576.
We will call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2,
3, 4, and 5, giving the pandigital, 918273645, which is the
concatenated product of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be
formed as the concatenated product of an integer with (1,2, ..., n)
where n > 1?

