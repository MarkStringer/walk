use Cwd;
use lib cwd;
use strict;
use warnings;
use 5.010;
use Days;

my $file   = shift || 'walk.csv';
open (my $fh, $file);
while(<$fh>)
{
	/(\d+)\s+(\d+\.?\d*)\s+(\d+\.?\d*)/;
	print $1."\t".$3."\n";	
}
