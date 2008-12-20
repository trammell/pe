#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings;
use Pythag;

my @triples = ( [3,4,5] );

my %src;

while (@triples) {
    my $t = shift @triples;
    #print "t=@$t";
    my $per = $t->[0] + $t->[1] + $t->[2];  # perimeter
    next if $per > 2_000_000;

    for (my $i = 1; $i * $per < 2_000_000; $i++) {
        push @{ $src{$i * $per} }, 
            [ map { $_ * $i } @$t ];
    }

    push @triples, genpt(@$t);
}

my $count = grep { scalar(@{$src{$_}}) == 1 } keys %src;
print $count;

__END__

http://projecteuler.net/index.php?section=problems&id=75

Problem 75
30 July 2004

It turns out that 12 cm is the smallest length of wire that can be bent to
form an integer sided right angle triangle in exactly one way, but there
are many more examples.

    12 cm: (3,4,5)
    24 cm: (6,8,10)
    30 cm: (5,12,13)
    36 cm: (9,12,15)
    40 cm: (8,15,17)
    48 cm: (12,16,20)

In contrast, some lengths of wire, like 20 cm, cannot be bent to form an
integer sided right angle triangle, and other lengths allow more than one
solution to be found; for example, using 120 cm it is possible to form
exactly three different integer sided right angle triangles.

    120 cm: (30,40,50), (20,48,52), (24,45,51)

Given that L is the length of the wire, for how many values of L <=
2_000_000 can exactly one integer sided right angle triangle be formed?

