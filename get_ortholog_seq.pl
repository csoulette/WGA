


$hits = $ARGV[0];
$blast_out = $ARGV[1];

open (IN1, $hits);
open (IN2, $blast_out);

%hit_list = ();

while (<IN1>) {
    chomp;
($pair = $_ ) =~ s/\n//;
$hit_hash{$pair} = "";
}    




while (<IN2>) { 
    chomp;
    $hit = join ("\t", sort ((split)[0,1]));
($hit_hash{$hit} .= "$_\n") if exists $hit_hash{$hit};

}

foreach $thing (keys %hit_hash) {
    print ">$thing\n$hit_hash{$thing}\n\n";
}
