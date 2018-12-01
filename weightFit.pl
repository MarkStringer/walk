use Cwd;
use lib cwd;
use strict;
use warnings;
use Days;
use Fit;

my $c= pop || die "Something went wrong";
my $m= pop || die "Something went wrong";

#print "C is $c\n";
#print "M is $m\n";

my $x = 0;
my $y = 1;
my $increment = 10;

while ($x <= 375)
{
	$y = $m * $x + $c;
        my $newdate = dateFromDays("31122017", $x);
	$x += $increment;
	$newdate =~ s/(\d\d)(\d\d)(\d\d\d\d)/$1\/$2\/$3/g;
	print "$newdate "." ".$y;
	print "\n";

}

