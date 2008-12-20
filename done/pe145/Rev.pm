#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

package Rev;

use strict;
use warnings;
use base 'Exporter';

our $DEBUG = 1;

our @EXPORT_OK = 'is_reversible';

unless (caller()) {
    my $c = 0;
    N:
    for (1 .. 999_999_999) {
        next N if $_ % 10 == 0;
        my $t = $_ + reverse("$_");
        print "$_ ... t=$t c=$c" if $_ % 100_000 == 1;
        while ($t) {
            next N if $t % 2 == 0;
            $t = int($t/10);
        }
        $c++;
    }
    print "final result: c=$c";
}

__END__

http://projecteuler.net/index.php?section=problems&id=145

Problem 145
16 March 2007

Some positive integers n have the property that the sum [ n + reverse(n) ]
consists entirely of odd (decimal) digits. For instance, 36 + 63 = 99 and
409 + 904 = 1313. We will call such numbers reversible; so 36, 63, 409, and
904 are reversible. Leading zeroes are not allowed in either n or
reverse(n).

There are 120 reversible numbers below one-thousand.

How many reversible numbers are there below one-billion (10^9)?

