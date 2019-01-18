package FindNumber;

use strict;
use warnings;
use 5.010;
use Date::Calc qw(Delta_Days);

use Exporter;
our @ISA    = qw(Exporter);
our @EXPORT = qw(findNumber findMiles);

sub findNumber
{
     my $string = shift || return "";
     $string =~ /\d+/ || return;
     $string =~ /(\d+\.?\d*|\.\d+)/; ## deal explicitly with the possibility of no leading zero
     my $number = $1;
     return $1;
}

sub findMiles
{
     my $string = shift || return "";
     ## find a number between '-' and Mile(s)
     $string =~ /.*-(.*)mile.*$/i;
     return findNumber($1);
}
