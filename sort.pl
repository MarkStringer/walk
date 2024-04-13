use Cwd;
use lib cwd;
use strict;
use warnings;
use 5.010;
use Days;

my $dir   = shift || '.';
my $total = 0;
my $delim = "\t";

opendir my $dh, $dir or die "Could not open '$dir' for reading '$!'\n";
my @things = grep { $_ ne '.' and $_ ne '..' and /^walk.*\.txt$/ } readdir $dh;

@things = sort { numberOfDays($a) <=> numberOfDays($b) } @things;

my $thisYear = `date +"%Y"`;
$thisYear =~ s/\n+//g;

my $testRegex = 'walk(\d\d)(\d\d)';
$testRegex = $testRegex . $thisYear;
$testRegex = $testRegex . '.txt';

foreach my $thing (@things) {
    if ( $thing =~ /$testRegex/ ) {
        my $day   = $1;
        my $month = $2;
        my $year  = $thisYear;
        open( my $fh, '<', $dir . "\/" . $thing )
          || die "Could not open $thing";
        while ( my $row = <$fh> ) {
            if ( $row =~ /(\d+\.?\d*)\s+Mile.*/i ) {
                my $walk = $1;

                # print "$day\/$month\/$year$delim";
                print $year. $month . $day . $delim;
                print $walk;
                $total += $walk;
                $total = sprintf( "%.2f", $total );
                print "$delim$total";
                if ( $row =~ /Themis/ ) { print $delim. "with Themis" }
                print "\n";
            }
            if ( $row =~ /(\d+\.?\d*)\s+k.*/i ) {
                my $walk = $1;
                $walk = $walk / 1.6;

                # print "$day\/$month\/$year$delim";
                print $year. $month . $day . $delim;
                print $walk;
                $total += $walk;
                $total = sprintf( "%.2f", $total );
                print "$delim$total";
                if ( $row =~ /Themis/ ) { print $delim. "with Themis" }
                print "\n";
            }

        }
    }
}
closedir $dh;
