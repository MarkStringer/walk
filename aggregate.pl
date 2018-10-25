#! /usr/local/bin/perl
use strict;
use warnings;
use 5.010;

my $file = "out.csv";

my %dates;

open(my $fh, '<:encoding(UTF-8)', $file) || die "failed to open file $file";
while (<$fh>)
{
	/(\d\d\/\d\d\/\d\d\d\d)\s+(\d*\.?\d*)\s+(.+)/;
	my $date = $1;
	my $walk = $2;
	##print $date." ".$walk."\n";

	if( ! $dates{$date})
	{
            $dates{$date} = $walk;
    	}
	else
	{
            $dates{$date} = $dates{$date} + $walk;
        }
}

foreach my $date (keys %dates)
{
	$date =~ /(\d\d)\/(\d\d)\/(\d\d\d\d)/;

        print "$3$2$1";
  print " $dates{$date}\n";
}
