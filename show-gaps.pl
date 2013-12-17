use strict;
use warnings;

my %geneFileMap = {};
open( my $fh, 'myco_tuberculosis_h37rv.fasta' );
while (<$fh>) {
    next if $. < 2; # Skip first line
    chomp;
    $geneFileMap{'>MycoTuberH37Rv'}  .= $_;
}

open( my $fh2, 'myco_ulcerans.fasta' );
while(<$fh2>) {
	next if $. < 2;
	chomp;
	$geneFileMap{'>MycoUlceransAgy99'} .= $_;
}

#print $geneFileMap{'>MycoUlceransAgy99'};

my $file = 'gaps.fasta';
open( my $info, $file);
while( my $line = <$info>)  {   
	my @values = split('\s', $line);
	(my $lineNumbers = $values[2]) =~ s/^\(//g;
	($lineNumbers = $lineNumbers) =~ s/\)$//g;
	my @gapPositions = split('\.\.', $lineNumbers);
	my $gapString = "";
	$gapString =  substr($geneFileMap{$values[0]}, $gapPositions[0], $gapPositions[1]);     
       if(length($gapString) > 1 )
       {
	   print $values[0] . $lineNumbers."\n";
	   print $gapString ."\n";
       }
        
}

close $info;
