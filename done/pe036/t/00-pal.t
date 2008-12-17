use strict;
use warnings;

#use Data::Dumper;
use Test::More 'no_plan';

use_ok('Pal');

ok( Pal::is_decimal_palindrome(101) );
ok(!Pal::is_decimal_palindrome(102) );
ok( Pal::is_decimal_palindrome(585) );
ok( Pal::is_decimal_palindrome(2992) );

ok( Pal::is_binary_palindrome(1) );
ok(!Pal::is_binary_palindrome(2) );
ok( Pal::is_binary_palindrome(3) ) or diag(sprintf ">%b<", 3);
ok(!Pal::is_binary_palindrome(4) );
ok( Pal::is_binary_palindrome(5) );
ok( Pal::is_binary_palindrome(585) );
ok(!Pal::is_binary_palindrome(586) );

