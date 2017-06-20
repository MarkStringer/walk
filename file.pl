use v5.10;
use strict;

my $filestring = "";
$filestring .= "write";
my $datestring = `date +%d%m%Y`;
$datestring =~ s/\s+//g;
$filestring = $filestring.$datestring.'.txt';
say $filestring;
system("touch $filestring");
