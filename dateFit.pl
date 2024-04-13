use Cwd;
use lib cwd;
use strict;
use warnings;
use Days ;

my $file = pop;

open(my $fh, '<', $file) || die "could not open file\n";
while (my $line = <$fh>)
{
	my $new_line = $line;
        if($line =~ /(\d\d)\/(\d\d)\/(\d\d\d\d)/)
	{
            my $numberOfDays =  numberOfDaysIncremental("31122017", "$1$2$3");
	    $new_line =~ s/(\d\d)\/(\d\d)\/(\d\d\d\d)/$numberOfDays/;
	    print $new_line;

        }  
}


