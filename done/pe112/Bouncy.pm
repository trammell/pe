#!/usr/bin/perl -l

package Bouncy;

use strict;
use warnings;
use base 'Exporter';
use Data::Dumper;

our @EXPORT_OK = qw( is_increasing is_decreasing is_bouncy );

unless (caller()) {

    my $j = 0;
    my ($inc,$dec,$bouncy) = (0,0,0);
    my $pct;

    {
        $j++;
        print "at j=$j (pct=$pct)" if $j % 10_000 == 0;
        if (is_increasing($j)) {
            $inc++;
        }
        elsif (is_decreasing($j)) {
            $dec++;
        }
        else {
            $bouncy++;
        }

        $pct = sprintf "%.6f", 100.0 * $bouncy / $j;
        redo if $pct < 99.0;
    }

    print "j=$j inc=$inc dec=$dec bouncy=$bouncy pct=$pct";

}

sub is_increasing {
    my @d = split //, $_[0];
    for (0 .. $#d - 1) {
        return 0 if $d[$_] > $d[$_ + 1];
    }
    return 1;
}

sub is_decreasing {
    my @d = split //, $_[0];
    for (0 .. $#d - 1) {
        return 0 if $d[$_] < $d[$_ + 1];
    }
    return 1;
}

sub is_bouncy {
    return 0 if is_increasing($_[0]);
    return 0 if is_decreasing($_[0]);
    return 1;
}

1;

__END__

Working from left-to-right if no digit is exceeded by the digit to its left it
is called an increasing number; for example, 134468.

Similarly if no digit is exceeded by the digit to its right it is called a
decreasing number; for example, 66420.

We shall call a positive integer that is neither increasing nor decreasing a
"bouncy" number; for example, 155349.

Clearly there cannot be any bouncy numbers below one-hundred, but just over
half of the numbers below one-thousand (525) are bouncy. In fact, the least
number for which the proportion of bouncy numbers first reaches 50% is 538.

Surprisingly, bouncy numbers become more and more common and by the time we
reach 21780 the proportion of bouncy numbers is equal to 90%.

Find the least number for which the proportion of bouncy numbers is exactly
99%.

