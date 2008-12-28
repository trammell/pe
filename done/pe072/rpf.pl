#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use lib "$ENV{HOME}/work/project-euler/lib";
use Data::Dumper;
use GCD;
use Totient 'Phi';
use List::Util 'sum';

my $sum = 0;
for my $i (2 .. 20) {
    my $phi = Phi($i);
    $sum += $phi;
    print "nrpf($i)=", nrpf($i), " Phi($i)=$phi sum=$sum";
}

print sum map { Phi($_) } 2 .. 1_000_000;

#print Dumper([rpf(5)]);
#my @f = rpf(8);
#print scalar @f;

sub nrpf {
    my $d = shift;
    my @f = rpf($d);
    return scalar @f;
}

sub rpf {
    my $dmax = shift;
    my @f;
    for my $d (2 .. $dmax) {
        for my $n (1 .. $d-1) {
            next unless gcd($n,$d) == 1;
            push @f, [ $n, $d ];
        }
    }
    return @f;
}

1;

__END__


