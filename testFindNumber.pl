use Cwd;
use lib cwd;
use strict;
use warnings;
use 5.010;
use FindNumber;
use Test::Simple tests => 14;

ok (findNumber (" ") eq "", "Attempt ' '");
ok (findNumber("\x0D\x0A\x0C") eq "", "Attempt x0D x0A x0C");
ok (findNumber("\x0D\x0A\x0D\x0A") eq "", "Attempt x0D x0A x0D x0A");

ok (findNumber ("\r\t\n") eq "", "Attempt '\\r\\t\\n'");
ok(findNumber("1.1") == 1.1, "Attempt '1.1'");
ok(findNumber("0.1") == .1, "Attempt '0.1'");
ok(findNumber("1") == 1, "Attempt '1'");
ok(findNumber("This is test with some other stuff in it 123") == 123, " Attempted 'This is test with some other stuff in it 123'");
ok(findNumber("-1") == 1, "Attempt '-1' (find 1)");

ok(findMiles("-1mile")==1, "Attempt '-1mile' (find 1)");
ok(findMiles("-.5mile")==0.5, "Attempt '-.5mile' (find 0.5)");
ok(findMiles("-00.mile")==0, "Attempt '-00.mile' (find 0)");

ok(findMiles("- 5 Miles")==5, "Attempt '- 5 Miles' (find 5)");
ok(findMiles("- 0.45 Miles")==.45, "Attempt '- 0.45 Miles' (find 0.45)");
ok(findMiles("- 5.45 Miles")==5.45, "Attempt '- 5.45 Miles' (find 5.45)");
ok(findMiles("Some shizzle - and then - 5.45 Miles")==5.45, "Attempt 'Some shizzle - and then - 5.45 Miles' (find 5.45)");

open( my $fh, '<', 'test01.txt' ) || die "Couldn't find the test file.";

while (<$fh>)
{
   ok(findMiles($_) eq "", "No Mile lines in file");
}







