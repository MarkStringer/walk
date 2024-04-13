use strict;
use warnings;
use 5.010;

my $file = 'preThemis.csv';
my $total = 0;
my $delim = "\t";

open(my $fh, '<', $file) or die "Could not find the Themis file";
while ( my $row = <$fh> ) {

	if($row =~ /^(\S+)\s+(\S+)/)
	{
		$total += $2;
		say $1.$delim.$2.$delim.$total;
		
	}
}
close $fh;
