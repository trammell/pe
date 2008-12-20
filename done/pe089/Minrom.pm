#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

package Minrom;

use strict;
use warnings;
use base 'Exporter';

our @EXPORT_OK = 'minrom';

unless (caller()) {
    my $saved = 0;
    while (<>) {
        chomp;
        s/\s//g;
        my $r = minrom($_);
        my $s = length($_) - length($r);
        print "$_ = $r (saved $s characters)";
        $saved += $s;
    }
    print "saved a total of $saved characters";
}

sub minrom {
    my $r = shift;

    $r =~ s/IIIII/V/g;
    $r =~ s/VIIII/IX/g;
    $r =~ s/IIII/IV/g;
    $r =~ s/VV/X/g;

    $r =~ s/XXXXX/L/g;
    $r =~ s/LXXXX/XC/g;
    $r =~ s/XXXX/XL/g;
    $r =~ s/LL/C/g;

    $r =~ s/CCCCC/D/g;
    $r =~ s/DCCCC/CM/g;
    $r =~ s/CCCC/CD/g;
    $r =~ s/DD/M/g;

    return $r;
}

1;

__END__

The rules for writing Roman numerals allow for many ways of writing each
number (see FAQ: Roman Numerals). However, there is always a "best" way of
writing a particular number.

For example, the following represent all of the legitimate ways of writing
the number sixteen:

    IIIIIIIIIIIIIIII
    VIIIIIIIIIII
    VVIIIIII
    XIIIIII
    VVVI
    XVI

The last example being considered the most efficient, as it uses the least
number of numerals.

The 11K text file, roman.txt (right click and 'Save Link/Target As...'),
contains one thousand numbers written in valid, but not necessarily
minimal, Roman numerals; that is, they are arranged in descending units and
obey the subtractive pair rule (see FAQ for the definitive rules for this
problem).

Find the number of characters saved by writing each of these in their
minimal form.

Note: You can assume that all the Roman numerals in the file contain no
more than four consecutive identical units.

