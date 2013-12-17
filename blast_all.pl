@gap_fastas = @ARGV;

foreach $file (@gap_fastas) { 
    system ("makeblastdb -in $file -dbtype nucl");
}

foreach $file (0..$#gap_fastas) {
    length($gap_fastas[$file+1]) || last;
    ($org1,$org2) = &get_name($gap_fastas[$file],$gap_fastas[$file+1]);
    
    system("blastn -query $gap_fastas[$file] -db $gap_fastas[$file+1] -outfmt \"6 qacc sacc qstart qend sstart send score evalue length pident\" > $org1\_$org2\.out");

    system("blastn -query $gap_fastas[$file+1] -db $gap_fastas[$file] -outfmt \"6 qacc sacc qstart qend sstart send score evalue length pident\" > $org2\_$org1\.out");
}


sub get_name () {
    $temp1 = $_[0];
    $temp2 = $_[1];

   ($name1) =  $temp1 =~ /(.+)_gaps/;
    ($name2) =  $temp2 =~ /(.+)_gaps/;
   
    return ($name1,$name2)
}
