use English;

foreach $file (@ARGV) {

    open (IN1, $file);
    $/ = ">";
while (<IN1>) {
chomp; 
   /\n/;
($h,$s) = ($PREMATCH,$POSTMATCH);
$h =~ s/\s//g;
@qlist = sort {$a<=>$b} split(/\s+/,$s);
foreach $cord (0..$#qlist) {

($start,$end) = split(/\.\./,$qlist[$cord]);
($nee,$noo) = split(/\.\./,$qlist[$cord+1]);

if (($start>$nee) && ($start<$noo)) {
    print "Start Overlap\t$start..$end\t$start_b4..$end_b4\n";
}

if (($end>$nee) && ($end<$noo)) {
    print "End Overlap\t$start..$end\t$nee..$noo\n";
}

}
}
}
die;





foreach $query (keys %query_hash) {

@qlist = sort {$a<=>$b} split(/\t/, $query_hash{$query});
print "Finding Overlaps in $query...\n";

foreach $cord (@qlist) {

($start,$end) = split(/\.\./,$cord);


if (($start>$start_b4) && ($start<$end_b4)) {
    print "Start Overlap\n";
}

if (($end>$start_b4) && ($end<$end_b4)) {
    print "End Overlap\n";
}
($start_b4,$end_b4) = ($start,$end);
}
}
print "Done.\n";
