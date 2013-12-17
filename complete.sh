#!/bin/bash

#promer MycoAviumk10.fasta query.fasta 
show-coords -bHT out.delta > new.coords
perl get_promum.pl new.coords > coords_by_org

perl get_gaps.pl coords_by_org > gaps.fasta
perl show-gaps2.pl gaps.fasta MycoTuberH37Rv.fasta MycoUlceransAgy99.fasta MycoAviumk10.fasta > complete.fasta
