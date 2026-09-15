#!/usr/bin/env perl
# Splits a pedometer export file (one line per day, format:
#   YYYYMMDD: As per pedometer -  X.XX Miles
# ) into individual walkDDMMYYYY.txt files matching this repo's convention.
#
# Usage:
#   perl split_pedometer.pl <input_file> [--dry-run] [--force]
#
#   --dry-run   don't write anything; print the filename and contents
#               that would be created for each line
#   --force     overwrite existing walkDDMMYYYY.txt files (default: skip them)

use strict;
use warnings;
use 5.010;

my $input;
my $dryRun = 0;
my $force  = 0;

foreach my $arg (@ARGV) {
    if    ( $arg eq '--dry-run' ) { $dryRun = 1 }
    elsif ( $arg eq '--force' )   { $force  = 1 }
    else                          { $input  = $arg }
}

die "Usage: perl split_pedometer.pl <input_file> [--dry-run] [--force]\n"
  unless defined $input;

open( my $fh, '<', $input ) or die "Could not open '$input': $!\n";

my $written = 0;
my $skipped = 0;

while ( my $line = <$fh> ) {
    chomp $line;
    next unless $line =~ /^\s*(\d{4})(\d{2})(\d{2}):\s*As per pedometer\s*-\s*(\d+\.?\d*)\s*Miles/i;

    my ( $year, $month, $day, $miles ) = ( $1, $2, $3, $4 );
    my $filename = "walk${day}${month}${year}.txt";
    my $content  = "From pedometer - ${miles} Miles\n";

    if ( $dryRun ) {
        print "$filename:\n$content\n";
        next;
    }

    if ( -e $filename && !$force ) {
        print "Skipping $filename (already exists)\n";
        $skipped++;
        next;
    }

    open( my $out, '>', $filename ) or die "Could not write '$filename': $!\n";
    print $out $content;
    close $out;
    print "Wrote $filename\n";
    $written++;
}

close $fh;

unless ( $dryRun ) {
    print "\n$written file(s) written, $skipped skipped.\n";
}
