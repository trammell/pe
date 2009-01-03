#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use List::Util 'sum';

my $LIMIT = 1e8;

my @scs = (0,1,5);

while (1) {
    my $i = $#scs;
    print "i=$i" if $i % 100 == 0;
    push @scs, $scs[$i] + ($i + 1)*($i + 1);
    last if $scs[-1] - $scs[-3] > $LIMIT;
}

print "@scs[0..9]";
print scalar(@scs);
print $scs[-1];
print scs(6,12);

my @pal;

for my $i (1 .. $#scs - 1) {
    for my $j ($i + 1 .. $#scs) {
        my $s = scs($i,$j);
        next if $s > $LIMIT;
        next unless "$s" eq reverse("$s");
        print "scs($i,$j)=$s";
        push @pal, $s;
    }
}

# check against known good values
{
    my @p = grep { $_ < 1000 } @pal;
    die unless @p == 11;
    die unless 4164 == sum @p;
}

@pal = sort { $a <=> $b } @pal;
print "@{[ scalar @pal ]} palindromes: @pal";
print "sum=", sum @pal;

{
    my %p = map { $_ => 1 } @pal;
    print scalar keys %p;
    print sum keys %p;
}

sub scs {
    my ($i,$j) = @_;
    return $scs[$j] - $scs[$i - 1];
}

