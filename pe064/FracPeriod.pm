#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

use strict;
use warnings FATAL => 'all';

# make an iterator
# generate a's until we see a pattern
# get the period

my $odd = 0;

for my $n (1 .. 10_000) {
    my $p = find_period($n);
    next if $p % 2 == 0;
    $odd++;
}

print "count of numbers with odd period: $odd";

sub period {
    my $d = shift;
    my $s = Math::BigFloat->new("$d")->bsqrt();
    my $it = ConFrac::make_iterator($s);

    my @seq;
    my %seen;

    for (my $i=0;;$i++) {
        my ($a,$num,$den,$next) = $it->();
        my $key = join q( ), $a->bstr, $next->copy->bround(20)->bstr;
        push @seq, $key;
        last if $seen{ $key };
        $seen{ $key } = 1;
    }

    # now find the period

    my @r = reverse @seq;

}

