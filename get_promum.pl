#this takes a modified promer output...check new.coords...

use English;

foreach $file (@ARGV) {
    open (IN, $file);
    
    while ($line = <IN>) { 
        $line =~ s/\|//g;
	@d = split(/\s+/,$line);
	$hash{$d[7]} .= "$d[0]\.\.$d[1]" . "\t";
        $ohash{"$d[7]ref"} .= "$d[2]\.\.$d[3]" . "\t";
    }
}

foreach $key (keys %hash) {
    @list = sort {$a<=>$b} split(/\s+/, $hash{$key});

    foreach $coord (0..$#list) {
	(length($list[$coord])) || next;
	($current,$next) = ($list[$coord],$list[$coord+1]);
	($cstart,$cend) = split(/\.\./, $current);
	($nstart,$nend) = split(/\.\./, $next);


	if (($cend>=$nstart) && ($cend<=$nend)) {
	    $tally++;
	    $final_end = false;
	    $position = 2;
	    $last_end = $nend;
	    $list[$coord+1] = s/.+//;
	    do {
		$nextnext = $list[$position];
		($next_start,$next_end) = split(/\.\./, $nextnext);
		if(($last_end>$next_start) && ($last_end<$next_end)) {
		    $position++;
		    $last_end = $next_end;
		    $list[$position] =~ s/.+//;
		}
		else {
		    $final_end = true;
		}
	    }
	    until ($final_end =~ /true/);
$cend  = $last_end; 
	}

$fixed_list .= "$cstart..$cend\t";	
	
    }

print ">$key\n$fixed_list\n";
}



foreach $ref_match (keys %ohash) {
    @{$ohash{$ref_match}}  = sort {$a<=>$b} split(/\s+/, $ohash{$ref_match});
}

foreach $first_ref (keys %ohash) {
        
    foreach $first_cords (@{$ohash{$first_ref}}) {
	($s1,$e1) = split(/\.\./, $first_cords);
	
	foreach $second (keys %ohash) {
	    ($first_ref eq $second) && next;
	    	    
	    foreach $second_cords (@{$ohash{$second}}) {
		($s2,$e2) = split(/\.\./, $second_cords);
		
		
		if ( ($s2<$s1) && ($s1<$e2) && ($e2<=$e1) ) {
		    $overlap_list .= "$s1..$e2\t";
		    next;
		    
		} 
		if ( ($s2<$s1) && ($e2>$e1) ) { 
		    $overlap_list .= "$s1..$e1\t";
		    next;
		}
		
		if ( ($s2>=$s1) && ($e2<=$e1) ) { 
		    $overlap_list .= "$s2..$e2\t";
		    next;
		}
		
		if ( ($s2>=$s1) &&  ($s2<$e1) && ($e2>$e1) ) {
		    $overlap_list .= "$s2..$e1\t";
		    next;
		}
		
	    }
	    
	}
    }
}

print ">RefOverlaps\n$overlap_list\n";
