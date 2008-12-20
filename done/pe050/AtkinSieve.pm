#!/usr/bin/perl -l
# vim: set ai et ts=4 tw=75 :

my @primes = (2,3,5);
my $pvec = q();
my $max = 1_000_000;

for (0 .. $max) {


}

__END__

From http://en.wikipedia.org/wiki/Sieve_of_Atkin:

In the algorithm:

  * All remainders are modulo-sixty remainders (divide the number by sixty
    and return the remainder).
  * All numbers, including x and y, are whole numbers (positive integers).
  * Flipping an entry in the sieve list means to change the marking (prime
    or nonprime) to the opposite marking.

  1. Create a results list, filled with 2, 3, and 5.
  2. Create a sieve list with an entry for each positive whole number; all
     entries of this list should initially be marked nonprime.
  3. For each entry in the sieve list:
    * If the entry is for a number with remainder 1, 13, 17, 29, 37, 41,
      49, or 53, flip it for each possible solution to 4x^2 + y^2 =
      entry_number.
    * If the entry is for a number with remainder 7, 19, 31, or 43, flip it
      for each possible solution to 3x^2 + y^2 = entry_number.
    * If the entry is for a number with remainder 11, 23, 47, or 59, flip
      it for each possible solution to 3x^2-y^2 = entry_number when x > y.
    * If the entry has some other remainder, ignore it completely.
  4. Start with the lowest number in the sieve list.
  5. Take the next number in the sieve list still marked prime.
  6. Include the number in the results list.
  7. Square the number and mark all multiples of that square as nonprime.
  8. Repeat steps five through eight.

