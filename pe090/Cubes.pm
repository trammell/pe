#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use Data::Dumper;

my %seen;
my $count = 0;

for my $i (102_345 .. 546_789) {
    print "i=$i" if $i % 1_000 == 0;
    my $d1 = mk_die($i);

    next if scalar(keys %$d1) != 6;

    my $c = ($d1);

    my ($r1, $r2) = mk_range($c);

    for my $j ($r1 .. $r2) {

        my $d2 = { %$c, map { $_ => 1 } split //, $j };
        #next if scalar(keys %$d2) != 6;

        #next if $seen{ $d1 }{ $d2 };
        #next if $seen{ $d2 }{ $d1 };
        #$seen{ $d1 }{ $d2 } = $seen{ $d2 }{ $d1 } = 1;

        next unless shows_all($d1,$d2);

        my $s1 = as_string($d1);
        my $s2 = as_string($d2);
        my $sc = as_string($c);

        for my $x (complete($d1)) {

            my $sx = join q(), sort keys %$x;

            for my $y (complete($d2)) {

                my $sy = join q(), sort keys %$y;

                next if $seen{ $sx }{ $sy };
                next if $seen{ $sy }{ $sx };
                $seen{ $sx }{ $sy } = $seen{ $sy }{ $sx } = 1;

                print "found i=$i j=$j sx=$sx sy=$sy sc=$sc r1=$r1 r2=$r2 count=$count";

                $count++;

            }
        }
    }
}

#print scalar keys %good;
print $count;

sub mk_die {
    my %d;
    for my $x (@_) {
        if (ref($x) eq 'HASH') { %d = (%d, %$x); }
        else { $d{$_} = 1 for split //, $x; }
    }
    return \%d;
}

sub mk_range {
    my $n = 6 - scalar(keys %{$_[0]});
    return (0, (10 ** $n) - 1);
}

sub start_die {
    my $d = $_[0] || {};
    my $c = {};
    for (grep { !$d->{$_} } 0, 1, 2, 3, 4, 5, 8) {
        $c->{$_} = 1;
    }
    return $c;
}

sub complete {
    my $d = shift;
    my $n = 6 - scalar(keys %$d);
    my @c;
    for my $s (map { sprintf "%0${n}d", $_ } 0 .. (10 ** $n) - 1) {
        my %tmp = (%$d, map { $_ => 1 } split //, $s );
        next unless scalar(keys %tmp) == 6;
        push @c, \%tmp;
    }
    return @c;
}

sub as_string {
    my $d = shift;
    return join q(), sort keys %$d;
}

sub shows_all {
    my ($d1,$d2) = @_;

    return 0 unless $d1->{6} || $d1->{9} || $d2->{6} || $d2->{9};

    # 01
    {
        last if $d1->{0} && $d2->{1};
        last if $d1->{1} && $d2->{0};
        return 0;
    }

    # 04
    {
        last if $d1->{0} && $d2->{4};
        last if $d1->{4} && $d2->{0};
        return 0;
    }

    # 09
    {
        last if $d1->{0} && $d2->{9};
        last if $d1->{9} && $d2->{0};
        last if $d1->{0} && $d2->{6};
        last if $d1->{6} && $d2->{0};
        return 0;
    }

    # 16
    {
        last if $d1->{1} && $d2->{6};
        last if $d1->{6} && $d2->{1};
        last if $d1->{1} && $d2->{9};
        last if $d1->{9} && $d2->{1};
        return 0;
    }

    # 25
    {
        last if $d1->{2} && $d2->{5};
        last if $d1->{5} && $d2->{2};
        return 0;
    }

    # 36
    {
        last if $d1->{3} && $d2->{6};
        last if $d1->{3} && $d2->{9};
        last if $d1->{6} && $d2->{3};
        last if $d1->{9} && $d2->{3};
        return 0;
    }

    # 49 *and* 64
    {
        last if $d1->{4} && $d2->{9};
        last if $d1->{4} && $d2->{6};
        last if $d1->{6} && $d2->{4};
        last if $d1->{9} && $d2->{4};
        return 0;
    }

    # 81
    {
        last if $d1->{8} && $d2->{1};
        last if $d1->{1} && $d2->{8};
        return 0;
    }

    return 1;
}

1;

__END__

http://projecteuler.net/index.php?section=problems&id=90

Problem 90
04 March 2005

Each of the six faces on a cube has a different digit (0 to 9) written on it;
the same is done to a second cube. By placing the two cubes side-by-side in
different positions we can form a variety of 2-digit numbers.

For example, the square number 64 could be formed:

          +-----+      +-----+
         /     /|     /     /|
        +-----+ |    +-----+ |
        |     | |    |     | |
        |  6  | +    |  4  | +
        |     |/     |     |/
        +-----+      +-----+

[Forgive my ASCII art. -JT]

In fact, by carefully choosing the digits on both cubes it is possible to
display all of the square numbers below one-hundred: 01, 04, 09, 16, 25, 36,
49, 64, and 81.

For example, one way this can be achieved is by placing {0, 5, 6, 7, 8, 9} on
one cube and {1, 2, 3, 4, 8, 9} on the other cube.

However, for this problem we shall allow the 6 or 9 to be turned upside-down so
that an arrangement like {0, 5, 6, 7, 8, 9} and {1, 2, 3, 4, 6, 7} allows for
all nine square numbers to be displayed; otherwise it would be impossible to
obtain 09.

In determining a distinct arrangement we are interested in the digits on each
cube, not the order.

    {1, 2, 3, 4, 5, 6} is equivalent to {3, 6, 4, 1, 2, 5}
    {1, 2, 3, 4, 5, 6} is distinct from {1, 2, 3, 4, 5, 9}

But because we are allowing 6 and 9 to be reversed, the two distinct sets in
the last example both represent the extended set {1, 2, 3, 4, 5, 6, 9} for the
purpose of forming 2-digit numbers.

How many distinct arrangements of the two cubes allow for all of the square
numbers to be displayed?

Analysis:

    First die:    (000123468) => (0123468)
    Second die:   (149656941) => (14569)
    Union:        (012345689)
    Position=      123456789
    Intersection: (146)

