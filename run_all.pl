#!/usr/bin/perl
#Usage: Runs alignment on gaps generated by promer.
#syntax $./run_all.pl [ref_genome.fasta] [other_genome.fasta] [others.fasta]...
@genomes = @ARGV;

$fasta_list = join(" ", @genomes[0..$#genomes]);

foreach $file (@genomes) {
    ($tally++) 
	|| (($ref = $file)
	    && next);
    system ("cat $file >> query.fasta"); #If starting over please remove original query.fasta
}

#system ("promer $ref query.fasta");
#system ("show-coords -bHT out.delta > new.coords");
#system ("perl get_promum.pl new.coords > coords_by_org");
#system ("perl get_gaps.pl coords_by_org > gaps.fasta");
system ("perl show_gaps2.pl gaps.fasta $fasta_list");

    while ($fasta_list =~ /(\S+)(\.fasta)/g) {
($fasta_gap_list .= "$1_gaps$2 ");
}

system ("perl blast_all.pl $fasta_gap_list");

@out_files = sort `ls \| grep \".out\"`;
$out = join("\t", @out_files[0..$#out_files]);
$out =~ s/\n//g;
while  ($out =~ /(\S+)\s+(\S+)/g){
    system ("perl get_ortholog_pair.pl $& >> ortholog_pairs");
}

system ("perl get_ortholog_seq.pl $out ortholog_pairs > multi_gap_alignment.txt");
