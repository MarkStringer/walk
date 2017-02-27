use strict;
use warnings;
use 5.010;

sub numberOfDays
{
    my $thing = pop;
    my @days = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

    $thing =~ /walk(\d\d)(\d\d)(\d\d\d\d).*/ || return 0;
    my $day = $1;
    my $month = $2;
    my $year = $3;
    my $daysInPastMonths = 0;
    foreach my $i (0..$month)
    {
       $daysInPastMonths += $days[$i];
    }

    return $daysInPastMonths + $day + ($year *365);
} 

my $dir = shift // '.';
my $total = 0;
 
opendir my $dh, $dir or die "Could not open '$dir' for reading '$!'\n";
my @things = grep {$_ ne '.' and $_ ne '..' and /^walk.*\.txt$/} readdir $dh;

@things = sort {numberOfDays($a) <=> numberOfDays($b)} @things;

foreach my $thing (@things) {
    $thing =~ /walk(\d\d)(\d\d)(\d\d\d\d).*/ || return 0;
    my $day = $1;
    my $month = $2;
    my $year = $3; 
    open(my $fh, '<', $thing) || die "Could not open $thing";
    while (my $row = <$fh>) {
       if($row =~/(\d+\.?\d*)\s+Mile.*/)
       {
           my $walk = $1;
           print "$day\/$month\/$year,";
           say $walk;
           $total += $walk;
       }
       
   }
} 
closedir $dh;

