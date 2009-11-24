package Primes;

use strict;
use warnings FATAL => 'all';
use base 'Exporter';
use IO::Zlib;
use Time::HiRes qw( gettimeofday tv_interval );
use File::Basename 'dirname';

our @EXPORT = qw( primes is_prime );

my @PRIMES;

sub primes {
    load() unless @PRIMES;
    return @PRIMES;
}

sub max_prime {
    load() unless @PRIMES;
    return $PRIMES[-1];
}

my $lookup;
sub is_prime {
    my $n = shift;
    load() unless @PRIMES;
    $lookup ||= { map { $_ => 1 } @PRIMES };
    if ($n <= 1_000_000) {
        return $lookup->{ $n } ? 1 : 0;
    }

    # for $n sufficiently small, use trial division to test primality
    my $s = 1 + int(sqrt($n));
    if ($s <= 1_000_000) {
        for (my $i=0; $PRIMES[$i] < $s; $i++) {
            return 0 if $n % $PRIMES[$i] == 0;
        }
        return 1;
    }

    die "is_prime(n=$n) out of range";
}

sub load {
    return if @PRIMES;
    my $t = [gettimeofday];
    my $fh = IO::Zlib->new;
    my $path = dirname $INC{'Primes.pm'};
    $fh->open("$path/known-primes.txt.gz", "rb") or die $!;
    while (<$fh>) {
        chomp;
        push @PRIMES, $_;
    }
    $fh->close;
    warn "Loaded @{[ scalar @PRIMES ]} primes (@PRIMES[0 .. 5] ... ",
        "$PRIMES[-1]) in @{[ tv_interval($t) ]} seconds\n";
}

1;

