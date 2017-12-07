package Days;

use strict;
use warnings;
use 5.010;

use Exporter;
our @ISA    = qw(Exporter);
our @EXPORT = qw(numberOfDays);
sub numberOfDays
{
    my $thing = pop;
    my @days = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

    $thing =~ /walk(\d\d)(\d\d)(\d\d\d\d).*/ || return 0;
    my $day = $1;
    my $month = $2;
    $month = $month -1;
    my $year = $3;
    my $daysInPastMonths = 0;

    ## don't do this if it's January
    if ($month > 0)
    {
    	foreach my $i (0..$month)
    	{
       		$daysInPastMonths += $days[$i];
    	}
    }

    return $daysInPastMonths + $day + ($year *365);
} 
1;
