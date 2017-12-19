use strict;
use warnings;
use 5.010;
use Days ;

my $dir = shift // '.';
my $total = 0;
my $delim = "\t";

 
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
           print "$day\/$month\/$year$delim";
           print $walk;
           $total += $walk;
           say "$delim$total";
       }
       
   }
} 
closedir $dh;
