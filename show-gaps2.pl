use English;

$file1 = $ARGV[0];
$file2 = $ARGV[1];
$file3 = $ARGV[2];

open (IN, $file1);
open (IN1,$file2);


$/ = ">";

<IN>; #Get rid of first line in $file1
while (<IN>) {
    chomp;
    /\n/;
    ($header,$seq) = ($PREMATCH,$POSTMATCH);
    $seq =~ s/\n//g; #Make string on one line
    $sequence_hash{$header} = $seq;
}

<IN2>; #Get rid of first line in $file2
while (<IN1>) {
    chomp;
    /\n/;
    ($header,$seq) = ($PREMATCH,$POSTMATCH);
    $seq =~ s/\n//g; 
    $sequence_hash{$header} = $seq;
}



foreach $organism (keys %h) {
    length($organism) || next; #Gets rid of empty hash
    @sequence_array = $sequence_hash{$organism} =~ /(.)/g;
    open (IN2, $file3); #This opens gaps.fasta
    $tally = 1; #Gap naming Convention

    while (<IN2>) {
	chomp;
	/$organism/ || next; #Associates gap list with organism genome
	/\((\S+)\)/; #Grabs coordinate
	($start,$stop) = split(/\.\./,$1);
	$seq =  join("", @sequence_array[$start..$stop]);
	($start < $stop) || next;
	(length($seq)>19) || next;
	$tally++;
	print ">$organism\ID:$tally $start..$stop\n$seq\n";
    }
}
