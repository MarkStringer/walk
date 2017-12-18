use Days;
use Test::Simple tests => 11;

my @array_a = sort {numberOfDays($a) <=> numberOfDays($b)} ("walk22011969.txt", "walk22031969.txt", "walk22021969.txt");
my @array_b = qw(walk22011969.txt walk22021969.txt walk22031969.txt);
ok((@array_a~~@array_b)==1, "Test sort");

ok(numberOfDays("walk22012017.txt")== 736350, "Count Days");
ok(isLeapYear(2000)==1, "Leap year 2000 true");
ok(isLeapYear(1996)==1, "Leap Year 1996 true");
ok(isLeapYear(1997)==0, "Leap Year 1997 false");
ok(isLeapYear(1900)==0, "Leap Year 1900 false");
ok(numberOfDaysIncremental("22011969", "23011969")==1, "Test incremental");
ok(numberOfDaysIncremental("22011969", "22011969")==0, "Test 0 for same day");
ok(numberOfDaysIncremental("28022000", "01032000")==2, "Test weird Leap year");
ok(numberOfDaysIncremental("28021996", "28021997")==366, "Test ordinary Leap year");
ok(numberOfDaysIncremental("28021993", "28021995")==730, "Test ordinary Year");


