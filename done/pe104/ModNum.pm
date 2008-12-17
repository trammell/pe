#!/usr/bin/perl -l

package ModNum;

use strict;
use warnings;
use Math::BigInt;
use Data::Dumper;
use overload
    '+' => \&modsum,
    '""' => \&as_string;

# keep top thirty digits of numbers
my $kept = 30;

sub new {
    my ($class, %args) = @_;
    return bless [ @args{ qw( high low rem ) } ], $class;
}

sub ONE {
    return ModNum->new(
        high => Math::BigInt->bone,
        low  => 1,
        rem  => 0,
    );
}

sub high { return $_[0][0]; }       # high digits of number
sub low  { return $_[0][1]; }       # low digits of number
sub rem  { return $_[0][2]; }       # number of digits removed

sub modsum {
    my ($n1,$n2) = @_;

    # sort so that $n1 >= $n2
    if ($n1->len < $n2->len) {
        ($n1,$n2) = ($n2,$n1);
    }
    elsif ($n1->len == $n2->len && $n1->high < $n2->high) {
        ($n1,$n2) = ($n2,$n1);
    }

    # determine the new low
    my $low = ($n1->low + $n2->low) % 1_000_000_000;

    # determine the new high
    my $high = do {
        my $diff = $n1->len - $n2->len;
        my $h2 = Math::BigInt->new( substr($n2->high->bstr,$diff) );
        $n1->high + $h2;
    };

    # determine the new length
    my $len = do {
        my $diff = length($high->bstr) - $n1->len;
        $n1->len + $diff;
    };

#   # truncate $high to 30 characters
#   $high = do {
#       my $s = $high->bstr;
#       (length($s) > 30)
#           ? Math::BigInt->new( substr($s,0,30) )
#           : $high; 
#   };

    return ModNum->new(
        high => $high,
        low  => $low,
        len  => $len
    );
}

sub as_string {
    my $n = shift;
    sprintf "<ModNum: high=%d low=%d len=%d>", $n->high, $n->low, $n->len;
}

1;

