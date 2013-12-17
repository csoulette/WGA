use English;

@fastas = @ARGV;

foreach $file (@fastas) {
    ($file =~ /gaps/) 
	&& ($gap_file = $file)
	&& next;
    
    $/ = ">";
    open (IN, $file);
    <IN>; #Get rid of first line in $file
    while (<IN>) {
    chomp;
    /\n/;
    ($header,$seq) = ($PREMATCH,$POSTMATCH);
    $seq =~ s/\n//g; #Make string on one line
    $sequence_hash{$header} = $seq;
    }
}

foreach $organism (keys %sequence_hash) {
    length($organism) || next; #Gets rid of empty hash
    @sequence_array = $sequence_hash{$organism} =~ /(.)/g;
    open (IN2, $gap_file); #This opens gaps.fasta
    $tally = 1; #Gap naming Convention
    open (OUT1, ">$organism\_gaps.fasta");
    while (<IN2>) {
	chomp;
	/$organism/ || next; #Associates gap list with organism genome
	/\((\S+)\)/; #Grabs coordinate
	($start,$stop) = split(/\.\./,$1);
	$seq =  join("", @sequence_array[$start..$stop]);
	($start < $stop) || next;
	(length($seq)>19) || next;
	$tally++;
	print OUT1 ">$organism\ID:$tally $start..$stop\n$seq\n";
    }
    close OUT;
}
