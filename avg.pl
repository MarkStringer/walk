use Cwd;
use lib cwd;
use strict;
use warnings;
use 5.010;

my $last_line = `perl sort.pl | tail -n 1`;
$last_line =~ /(\d+\.\d+)$/;
my $distance = $1;

my $distance_left = 1500 - $distance;

my $days_left = 365- `date +%j`;

my $average = $distance_left / $days_left;

say "Average daily required walk = $average";
