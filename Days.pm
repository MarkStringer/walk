package Days;

use strict;
use warnings;
use 5.010;

use Exporter;
our @ISA    = qw(Exporter);
our @EXPORT = qw(numberOfDays isLeapYear numberOfDaysIncremental);
my @days = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
sub numberOfDays
{
    my $thing = pop;
    $thing =~ /walk(\d\d)(\d\d)(\d\d\d\d).*/ || return 0;
    numberOfDaysIncremental("01010001", "$1$2$3");
}
sub numberOfDaysIncremental
{
    my $secondDate = pop;
    my $firstDate = pop;
    $firstDate =~ /(\d\d)(\d\d)(\d\d\d\d)/ || return 0;
    my $firstDay = $1;
    my $firstMonth = $2;
    my $firstYear = $3;
    $secondDate =~ /(\d\d)(\d\d)(\d\d\d\d)/ || return 0;
    my $secondDay = $1;
    my $secondMonth = $2;
    my $secondYear = $3;

    my $counter =0;

    while(($firstDay!=$secondDay) || ($firstMonth!=$secondMonth) || ($firstYear != $secondYear))
    {
        $counter++;
        $firstDay++;
        if ($firstDay > ($days[$firstMonth-1] + (($firstMonth==2) && isLeapYear($firstYear))))
        {
		$firstDay = 1;
                $firstMonth++;
        }
        if ($firstMonth == 13)
        {
	   $firstMonth = 1;
           $firstYear++;
        }
}
return $counter;

}

sub isLeapYear
{
    my $year = pop;
    !($year %  400) && return 1;
    !($year %  100) && return 0;
    !($year %  4) && return 1;
    return 0;
}

1;
