use strict;
use warnings;

use Data::Dumper;
use Test::More 'no_plan';

use_ok('Pence','make_iter');

{
    my $i = make_iter(0 => 0);
    my @c;
    push @c, $i->();
    push @c, $i->();
    push @c, $i->();
    is_deeply(\@c, [ [] ]) or diag Dumper(\@c);
}

{
    my $i = make_iter(1 => 1);
    my @c;
    push @c, $i->();
    push @c, $i->();
    push @c, $i->();
    is_deeply(\@c, [ [] ]) or diag Dumper(\@c);
}

#{
#    my $i = make_iter(1 => 1);
#
#    my @change = $i->();
#    is_deeply(\@change, [1]) or diag Dumper(\@change);
#
#    is_deeply([$i->()], []);
#}

