use Days;
use Fit;
use Test::Simple tests => 12;

##ok(numberOfDays("walk22012017.txt")== 736350, "Count Days");
ok(isLeapYear(2000)==1, "Leap year 2000 true");
ok(isLeapYear(1996)==1, "Leap Year 1996 true");
ok(isLeapYear(1997)==0, "Leap Year 1997 false");
ok(isLeapYear(1900)==0, "Leap Year 1900 false");
ok(numberOfDaysIncremental("22011969", "23011969")==1, "Test incremental");
ok(numberOfDaysIncremental("22011969", "22011969")==0, "Test 0 for same day");
ok(numberOfDaysIncremental("28022000", "01032000")==2, "Test weird Leap year");
ok(numberOfDaysIncremental("28021996", "28021997")==366, "Test ordinary Leap year");
ok(numberOfDaysIncremental("28021993", "28021995")==730, "Test ordinary Year");
ok(numberOfDaysIncremental("01010001", "01010001")==0, "day 1");
ok(dateFromDays("01011900", 31)eq "01021900", "Date from Days");
ok(dateFromDays("01011900", 365)eq "01011901", "More dates from Days");

ok(dateFromDays("28021993", numberOfDaysIncremental("28021993", "28022005"))=="28022005");


my @numbers =getNumbersFromFile("testout.csv");

print @numbers;
print "\n";
ok(getNumbersFromFile("01012016","testout.csv")!=0, "Use testout");

ok(applyFormula(2,5,7)==17, "Apply Formula");
