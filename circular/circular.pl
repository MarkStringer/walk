#! /usr/local/bin/perl

use strict;
use warnings;
use 5.010;
use Math::Trig ':great_circle';
use Math::Trig qw(deg2rad rad2deg);

# Notice the 90 - latitude: phi zero is at the North Pole.
sub NESW { deg2rad($_[0]), deg2rad(90 - $_[1]) }


my @G = NESW( -0.0026889,51.4768563);
my @R = NESW(-0.0050472, 51.5066064);
## my $miles = great_circle_distance(@G, @R, 3959); 

my $miles = great_circle_distance(@G, @R);

say "Distance is" ,  $miles*3959;

  (my $thetad, my $phid, my $dird) =
    great_circle_destination(@G, 0, $miles);

 
say "Theta -is", rad2deg($thetad);
say "Phid -is", rad2deg($phid);


