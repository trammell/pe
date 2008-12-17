#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;

my @DIGITS = (0, 1, 2, 3, 6, 7, 8, 9);

my @log = load();

unless (caller()) {
    my @before;
    for (@log) {
        if (/(\d)(\d)(\d)/) {
            push @{ $before[$1] }, $2, $3;
            push @{ $before[$2] }, $3;
        }
    }
    for my $d (@DIGITS) {
        print $d, ' => ', su(@{ $before[$d] || [] });
    }
}

sub su {
    return sort { $a <=> $b } keys %{{ map { $_ => 1  } @_ }};
}

sub load {
    open(my $fh, "keylog.txt") or die $!;
    return map { chomp; $_ } <$fh>;
}


1;

__END__

A common security method used for online banking is to ask the user for three
random characters from a passcode. For example, if the passcode was 531278,
they may asked for the 2nd, 3rd, and 5th characters; the expected reply would
be: 317.

The text file, keylog.txt, contains fifty successful login attempts.

Given that the three characters are always asked for in order, analyse the file
so as to determine the shortest possible secret passcode of unknown length.

Analysis
========

First strip out duplicates from keylog.txt.  Then look at what numbers precede other

    0 precedes no other numbers
    1 precedes 02689
    2 precedes 089
    3 precedes 012689
    6 precedes 0289
    7 precedes 0123689
    8 precedes 09
    9 precedes 0

Working backwards, we get:

    73162890

