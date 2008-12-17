#!/usr/bin/perl -l

use strict;
use warnings;

# A palindromic number reads the same both ways. The largest palindrome made
# from the product of two 2-digit numbers is 9009 = 91 * 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

my @p;

foreach my $x (100 .. 999) {
    foreach my $y (100 .. 999) {
        next unless is_palindrome($x * $y);
        push @p, $x * $y;
    }
}

@p = sort { $b <=> $a } @p;

print "@p[0 .. 9]";

sub is_palindrome {
    my $n = "$_[0]";
    return 1 if $n =~ /^(\d)(\d)\2\1$/;
    return 1 if $n =~ /^(\d)(\d)(\d)\2\1$/;
    return 1 if $n =~ /^(\d)(\d)(\d)\3\2\1$/;
    return;
}

__END__

Even better:

$Solution=$multiply1*$multiply2;
$ReversedSolution=reverse $Solution;
         
if($ReversedSolution==$Solution)
{
print "$Solution\n";
}

