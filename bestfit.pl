use Cwd;
use lib cwd;
use strict;
use warnings;
use Days;
use Fit;

sub mean
{
  my @values = @{$_[0]};

# find the average
my $count = 0;
my $sum = 0;
foreach my $value (@values)
{
$count++;
$sum+= $value
}

my $average;
$average = $sum/$count;

return $average;
}


my @x_values;
my @y_values;
 
my $filename = pop;
my @numbers = getNumbersFromFile($filename);

##print @numbers;

 
# Read in two columns of numbers
foreach my $row (@numbers){

$row =~ /(\d+)\s+(\d+)/ || die "Can't parse the numbers";
my $current_x = $1;
push @x_values, $current_x;
my $current_y = $2;
push @y_values, $current_y;

##print "x is $current_x, y is $current_y \n";
}

##print "X average is ";
my $x_average = mean(\@x_values);
##print $x_average;
##print "\n";

##print "Y average is ";
my $y_average =  mean(\@y_values);
##print $y_average;
##print "\n";

# calculate the sum of each x point minus x average multiplied by each y point minus y average
my $counter = 0;
my $sum_top = 0;
my $sum_bottom = 0;
foreach(@x_values)
{
	$sum_top += ($x_values[$counter] - $x_average) * ($y_values[$counter] - $y_average);
        $sum_bottom += ($x_values[$counter] - $x_average) **2;
	$counter++;

}

##print "Sum Top is $sum_top\n";
##print "Sum Bottom is $sum_bottom\n";
my $m = $sum_top/$sum_bottom;
# this gives us "m" - the gradient.
##print "So the gradient is $m\n";

my $offset = $y_average - ($m * $x_average);

##print "And the offset is $offset\n";
my $pair = shift @numbers;
$pair=~ /(\d+)\s+(\d+)/ || die "couldn't parse this line";
my $x = $1;
for (my $i = $x; $i<($x+365); $i+=30)
{
    my $y = applyFormula($m, $i, $offset);
    my $dateToFormat = dateFromDays("01011900",$i);
    my $formattedDate;
    $dateToFormat =~ /(\d\d)(\d\d)(\d\d\d\d)/;
    $formattedDate = $1.'/'.$2."/".$3;

    print $formattedDate." ".$y."\n";
}

##foreach my $pair (@numbers)
##{
##    $pair=~ /(\d+)\s+(\d+)/ || die "couldn't parse this line";
##    my $x = $1;
##    my $y = applyFormula($m, $x, $offset);
##    my $dateToFormat = dateFromDays("01011900",$x);
##    my $formattedDate;
##    $dateToFormat =~ /(\d\d)(\d\d)(\d\d\d\d)/;
##    $formattedDate = $1.'/'.$2."/".$3;
##
##    print $formattedDate." ".$y."\n";
## 
##}
##
##
