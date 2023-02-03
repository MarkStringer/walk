use Cwd;
use lib cwd;
use strict;
use warnings;
use 5.010;
use Days;

my $testString = 'walk02022023.txt';

my $testRegex = 'walk(\d\d)(\d\d)';
$testRegex = $testRegex.'2023';
$testRegex = $testRegex.'.txt';
say $testRegex;

if ($testString =~ /$testRegex/)
{
	say "Matched";
}
