#!/usr/bin/perl -l

use strict;
use warnings FATAL => 'all';
use lib "$ENV{HOME}/work/project-euler/lib";
use Expmod 'expmod';

#print expmod(4,13,497);
#for my $a (3 .. 10) {
#    my @s = sequence($a);
#    print "a=$a @s";
#}
#exit;

my $sum = 0;
for my $a (3 .. 1000) {
    my $r = rmax_slow($a);
    $sum += $r;
}
print $sum;

sub sequence {
    my $a = shift;
    my $a2 = $a * $a;
    my $T1 = my $t1 = $a - 1;
    my $T2 = my $t2 = $a + 1;
    my @s;
    while (1) {
        $t1 = ($t1 + $T1) % $a2;
        $t2 = ($t2 + $T2) % $a2;
        last if $T1 == $t1 && $T2 == $t2;
        push @s, (($t1 + $t2) % $a2);
    }
    return @s;
}

sub rmax_slow {
    my $a = shift;
    my $a2 = $a * $a;
    my $rmax = 0;
    my $nmax = 0;
    my $T1 = my $t1 = $a - 1;
    my $T2 = my $t2 = $a + 1;
    my $n = 0;
    for my $n (0 .. $a - 1) {
        $t1 = ($t1 + $T1) % $a2;
        $t2 = ($t2 + $T2) % $a2;
        my $r = ($t1 + $t2) % $a2;
        next unless $r > $rmax;
        $rmax = $r;
        $nmax = $n;
    }
    print "rmax(a=$a;n=$nmax)=$rmax";
    return $rmax;
}

sub rmax {
    my $a = shift;
    my $a2 = $a * $a;
    my $rmax = 0;
    my $nmax = 0;
    my $t = my $T = 2 * $a;
    my $n = 0;
    while (1) {
        $n++;
        $t += $T;
        $t %= $a2;
        last if $t == $T;
        next unless $t > $rmax;
        $rmax = $t;
        $nmax = $n;
    }
    print "rmax(a=$a;n=$nmax)=$rmax";
    return $rmax;
}

=head2 rem($a,$n)

Returns C<< ((a-1)^n + (a+1)^n) % a^2 >>.

=cut

sub rem {
    my ($a, $n) = @_;
    return (expmod($a - 1,$n) + expmod($a + 1, $n)) % ($a * $a);
}

