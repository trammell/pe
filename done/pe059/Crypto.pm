#!/usr/bin/perl -l

use strict;
use warnings;
use Data::Dumper;
use List::Util qw( max min sum );
use Text::Wrap;

local $Text::Wrap::columns = 72;

local $Data::Dumper::Sortkeys = sub {
    return [ sort { $_[0]->{$b} <=> $_[0]->{$a} } keys %{ $_[0] } ];
};

unless (caller()) {

    my @ct = ct();

    print "entire set:";
    stats(@ct);

    for my $m (0,1,2) {
        print "ct[i] % 3 == $m";
        my @m = @ct[ grep { $_ % 3 == $m } 0 .. $#ct ];
        stats(@m);
    }

    #exit;

    while (1) {
        my @key = get_key();
        print "key=@key";
        my @pt = XOR(\@key,\@ct);
        print wrap(('>>> ') x 2, join(q(), @pt));
        print "sum=", sum map ord, @pt;
    }

}

sub XOR {
    my ($key, $ct) = @_;
    my @out = map { $key->[ $_ % 3 ] ^ $ct->[$_] } 0 .. $#$ct;
    return map chr($_), @out;
}

sub get_key {
    my $key;
    while (1) {
        print 'enter key (should match /^[a-z]{3}$/): ';
        chomp($key = <STDIN>);
        last if $key =~ /^[a-z]{3}$/;
    }
    return map ord($_), split //, $key;
}

sub ct {
    open(my $fh, 'cipher1.txt') or die $!;
    return split /,/, <$fh>;
}

sub stats {
    my @x = @_;

    print "n=", scalar(@x);
    print "range=", min(@x), "-", max(@x);

    my %h;
    $h{$_}++ for @x;

    my @f = (sort { $b <=> $a } values %h);
    print "freq=@f[0..10]...";
    my $cut = $f[5];
    print "cutoff=$cut";

    for (keys %h) {
        delete $h{$_} if $h{$_} < $cut;
    }

    print Dumper(\%h);

    my @ct = sort { $h{$b} <=> $h{$a} } keys %h;

    for my $char ('a' .. 'z') {
        print "$char => ", map { chr($_) } map { ord($char) ^ $_ } @ct;
    }


}

1;

__END__

http://projecteuler.net/index.php?section=problems&id=59

Problem 59
19 December 2003

Each character on a computer is assigned a unique code and the preferred
standard is ASCII (American Standard Code for Information Interchange). For
example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.

A modern encryption method is to take a text file, convert the bytes to ASCII,
then XOR each byte with a given value, taken from a secret key. The advantage
with the XOR function is that using the same encryption key on the cipher text,
restores the plain text; for example, 65 XOR 42 = 107, then 107 XOR 42 = 65.

For unbreakable encryption, the key is the same length as the plain text
message, and the key is made up of random bytes. The user would keep the
encrypted message and the encryption key in different locations, and without
both "halves", it is impossible to decrypt the message.

Unfortunately, this method is impractical for most users, so the modified
method is to use a password as a key. If the password is shorter than the
message, which is likely, the key is repeated cyclically throughout the
message. The balance for this method is using a sufficiently long password key
for security, but short enough to be memorable.

Your task has been made easy, as the encryption key consists of three lower
case characters. Using cipher1.txt (right click and 'Save Link/Target As...'),
a file containing the encrypted ASCII codes, and the knowledge that the plain
text must contain common English words, decrypt the message and find the sum of
the ASCII values in the original text.


Analysis:

