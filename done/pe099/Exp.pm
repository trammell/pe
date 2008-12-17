#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;

unless (caller()) {
    my $max = [ 0, 0, 0];   # base, exp, log(base^exp)
    my @be = load();
    foreach my $be (@be) {
        print "@$be...";
        my $log = $be->[1] * log( $be->[0] );
        next unless $log > $max->[2];
        $max = [ @$be, $log ];
        print "new max: @$max";
    }
    print "final max: @$max";

}

sub load {
    open(my $fh, "base_exp.txt") or die $!;
    my @out;
    while (<$fh>) {
        s/\s//g;
        push @out, [ split /,/, $_ ];
    }
    return @out;
}

1;

__END__

http://projecteuler.net/index.php?section=problems&id=99

Problem 99
01 July 2005

Comparing two numbers written in index form like 2^11 and 3^7 is not difficult,
as any calculator would confirm that 2^11 = 2048 < 3^7 = 2187.

However, confirming that 632382^518061 > 519432^525806 would be much more
difficult, as both numbers contain over three million digits.

Using base_exp.txt (right click and 'Save Link/Target As...'), a 22K text file
containing one thousand lines with a base/exponent pair on each line, determine
which line number has the greatest numerical value.

NOTE: The first two lines in the file represent the numbers in the example
given above.

