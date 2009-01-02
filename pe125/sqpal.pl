#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use List::Util 'sum';

my $LIMIT = 1e8;

my @scs = (0,1);

while (1) {
    my $i = $#scs;
    print "i=$i" if $i % 100 == 0;
    push @scs, $scs[$i] + ($i + 1)*($i + 1);
    last if $scs[-1] > 2 * $LIMIT;
}

print "@scs[0..9]";
print scalar(@scs);
print $scs[-1];
print scs(6,12);

my @pal;

for my $i (1 .. $#scs) {
    for my $j ($i + 1 .. $#scs) {
        my $s = scs($i,$j);
        next if $s > $LIMIT;
        next unless "$s" eq reverse("$s");
        print "scs($i,$j)=$s";
        push @pal, $s;
    }
}

@pal = sort { $a <=> $b } @pal;

print "@pal";

print scalar @pal;
print sum @pal;

{
    my @p = grep { $_ < 1000 } @pal;
    print scalar @p;
    print sum @p;
}

{
    my %p = map { $_ => 1 } @pal;
    print scalar keys %p;
    print sum keys %p;
}

sub scs {
    my ($i,$j) = @_;
    return $scs[$j] - $scs[$i-1];
}

