use v5.10;
use strict;

my $filestring = "";
$filestring .= "walk";
my $extraDate = join(" ", @ARGV) //'';
##say $extraDate;
my $commandString;
if ($extraDate)
{
   $commandString = "date --date=\'$extraDate\' +%d%m%Y";
   }
   else
   {
	   $commandString = "date +%d%m%Y";
   }
## say $commandString;


my $datestring = `$commandString` || die "Something wrong with the date string";
$datestring =~ s/\s+//g;
$filestring = $filestring.$datestring.'.txt';
say $filestring;
system("touch $filestring");
