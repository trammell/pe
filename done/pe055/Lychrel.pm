#!/usr/bin/perl -l

package Lychrel;

use strict;
use warnings;
use base 'Exporter';
use Data::Dumper;
use Math::BigInt;
use Scalar::Util 'blessed';

our $DEBUG;
our @EXPORT_OK = qw( L is_lychrel );

unless (caller()) {
    my $count = 0;
    $DEBUG = 0;
    for (1 .. 9_999) {
    #for (5 .. 5) {
        print "checking $_ ..." if $_ % 500 == 0;
        next unless is_lychrel($_);
        print "$_ is lychrel";
        $count++
    }
    print $count;
}

sub is_lychrel {
    my $n = shift;
    unless (blessed($n) && $n->can('bstr')) {
        $n = Math::BigInt->new("$n");
    }
    warn "is_lychrel(): n=@{[ $n->bstr ]}" if $DEBUG;
    $n = L($n);
    for (1 .. 50) {
        warn "    is_lychrel(): n => @{[ $n->bstr ]}" if $DEBUG;
        return 0 if is_symmetric($n->bstr);
        $n = L($n);
    }
    return 1;
}

sub is_symmetric {
    my $s = shift;
    return 1 if $s eq reverse($s);
    return 0;
}

sub L {
    my $n = shift;
    unless (blessed($n) && $n->can('bstr')) {
        $n = Math::BigInt->new("$n");
    }
    my $r = do {
        my $s = $n->bstr;
        my $rev = reverse("$s");
        warn "   $s => $rev\n" if $DEBUG;
        Math::BigInt->new($rev);
    };
    warn "   n=$n r=$r" if $DEBUG;
    return $n + $r;
}

1;

__END__

If we take 47, reverse and add, 47 + 74 = 121, which is palindromic.

Not all numbers produce palindromes so quickly. For example,

    349 + 943 = 1292,
    1292 + 2921 = 4213
    4213 + 3124 = 7337

That is, 349 took three iterations to arrive at a palindrome.

Although no one has proved it yet, it is thought that some numbers, like 196,
never produce a palindrome. A number that never forms a palindrome through the
reverse and add process is called a Lychrel number. Due to the theoretical
nature of these numbers, and for the purpose of this problem, we shall assume
that a number is Lychrel until proven otherwise. In addition you are given that
for every number below ten-thousand, it will either (i) become a palindrome in
less than fifty iterations, or, (ii) no one, with all the computing power that
exists, has managed so far to map it to a palindrome. In fact, 10677 is the
first number to be shown to require over fifty iterations before producing a
palindrome: 4668731596684224866951378664 (53 iterations, 28-digits).

Surprisingly, there are palindromic numbers that are themselves Lychrel
numbers; the first example is 4994.

How many Lychrel numbers are there below ten-thousand?

NOTE: Wording was modified slightly on 24 April 2007 to emphasise the
theoretical nature of Lychrel numbers.


