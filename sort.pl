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

foreach my $thing (@things) {
    $thing =~ /walk(\d\d)(\d\d)(\d\d\d\d).*/ || return 0;
    my $day   = $1;
    my $month = $2;
    my $year  = $3;
    open( my $fh, '<', $dir."\/".$thing ) || die "Could not open $thing";
    while ( my $row = <$fh> ) {
        if ( $row =~ /(\d+\.?\d*)\s+Mile.*/i ) {
            my $walk = $1;
            # print "$day\/$month\/$year$delim";
            print $year.$month.$day.$delim;
            print $walk;
            $total += $walk;
            $total = sprintf("%.2f", $total);
            print "$delim$total";
	    if ($row =~ /Themis/)
            { print $delim."with Themis"}
	    print "\n";
        }

    }
}
closedir $dh;
