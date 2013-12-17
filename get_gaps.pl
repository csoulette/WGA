#This script take in the output of get_promum.pl


use English;
$/ = ">";
<>;
while (<>) {
    chomp;
    /\n/;
    ($header,$coords) = ($PREMATCH,$POSTMATCH);

    $previous_end = 0;
    while ($coords =~ /(\S+)/g) {
	$coord = $1;
	($start,$end) = split(/\.\./, $coord);
	($previous_end>$start) && next;
	(($start-$previous_end)<20) && next;

	print ">$header  \($previous_end\.\.$start\)\n";

	$previous_end = $end;
    }
}
