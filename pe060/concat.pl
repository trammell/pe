#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use lib "$ENV{HOME}/work/project-euler/lib";
use Primes;
use Data::Dumper;
use List::Util 'sum';

my @families = ([]);
my @best;

my @primes = grep { $_ < 10_000 } primes();
for my $i (0 .. $#primes) {
    my $f = scalar @families;
    my $prime = $primes[$i];
    #next if $prime == 2 || $prime == 5;
    print "i=$i prime=$prime families=$f" if $i % 100 == 0;
    my @x;
    foreach my $fam (@families) {
        push @x, $fam;
        next unless is_compatible($fam,$prime);
        my $new = [ @$fam, $prime ];
        push @x, $new;
        if (@$new > @best) {
            @best = @$new;
            my $sum = sum @best;
            print "new best: @best, sum=$sum";
            exit if @best >= 5;
        }
    }
    @families = @x;
}

sub is_compatible {
    my ($family,$prime) = @_;
    for my $n (@$family) {
        return 0 unless are_compatible_primes($n,$prime);
    }
    return 1;
}

my %cache;
sub are_compatible_primes {
    my ($p1,$p2) = @_;
    $cache{$p1}{$p2} ||=
        (is_prime("$p1$p2") && is_prime("$p2$p1")) ? 1 : -1;
    return $cache{$p1}{$p2} > 0;
}

1;

