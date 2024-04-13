use v5.10;
use strict;

my $filestring = "walk";
my $extraDate = "";
my $writeString = "";
my $parsingWriteString = 0;

# Loop through the ARGV array to handle options manually
for my $i (0..$#ARGV) {
    if ($ARGV[$i] eq '-w') {
        $parsingWriteString = 1;
        next;
    } elsif ($ARGV[$i] eq '-d') {
        $parsingWriteString = 0;
        $extraDate = $ARGV[++$i] if defined $ARGV[$i];
        next;
    }

    if ($parsingWriteString) {
        $writeString .= " " if $writeString;
        $writeString .= $ARGV[$i];
    }
}

my $commandString;
if ($extraDate) {
    $commandString = "date --date=\'$extraDate\' +%d%m%Y";
} else {
    $commandString = "date +%d%m%Y";
}

my $datestring = `$commandString` || die "Something wrong with the date string";
$datestring =~ s/\s+//g;

$filestring = $filestring.$datestring.'.txt';
say $filestring;

# Create the file
system("touch $filestring");

# Write the string to the file if the -w flag is present
if ($writeString) {
    open my $fh, '>>', $filestring or die "Cannot open $filestring: $!";
    print $fh "$writeString\n";
    close $fh;
}

