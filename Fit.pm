package Fit;

use strict;
use warnings;
use 5.010;
use Days;

use Exporter;
our @ISA    = qw(Exporter);
our @EXPORT = qw(getNumbersFromFile applyFormula);

sub getNumbersFromFile
{
    my $file = pop;
    open(my $fh, '<',$file) || die "Could not open $file";
    my @numbers;
    while(my $row = <$fh>)
    {
	$row =~ /(\d\d)\/(\d\d)\/(\d\d\d\d)(\D+?)(\d+\.?\d*)(\D+?)(\d+\.?\d*)/ || die "Could not parse file";
        my $day = $1;
        my $month = $2;
        my $year = $3;
	my $miles = $7;
        my $newEntry = numberOfDaysIncremental("01011900","$day$month$year")." ".$miles;
        push(@numbers, $newEntry);
    }
    close($fh);
    return @numbers;
}

sub applyFormula
{
    my $c = pop;
    my $x = pop;
    my $m = pop;

return ($m * $x) + $c;
}




1;
