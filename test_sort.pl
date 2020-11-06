use Cwd;
use lib cwd;
use strict;
use warnings;
use 5.010;

say "Test 1";
my $output = `perl sort.pl testdir/onemile`;
$output =~ /31\/10\/2018\s+1\s+1/ || die "failed at test 1 output was $output";
say $output;
say "passed";


