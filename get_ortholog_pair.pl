$blast_out = $ARGV[0];
open (IN, $blast_out);

while (<IN>) {
    ($query,$subject) = ((split)[0],(split)[1]);
    ($q_name) = $query =~ /(.+)ID/;
    ($s_name) = $subject =~ /(.+)ID/;
    ($q_name eq $s_name) && next;
    
    ((split)[0] eq (split)[1]) && next;
    
    ($already{(split)[0]}++) 
	|| ($hits{join ("\t", sort ((split)[0,1]))}++);
    
}




foreach $key (keys %hits) {
    ($hits{$key} == 2) && 
	print "$key\n";

}
