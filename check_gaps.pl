while (<>) { 
    /\((.*?)\)/;

    $q = $1;

    ($w,$r) = split(/\.\./,$q);
if ($w>$r) {
print "THROW A SHITFIT\n\n";
}
$length = $r-$w;

    if ($length<20) {
    print "$_\n";

    }
$lengths .= "$length\t";


} 

@small = sort {$a<=>$b} split(/\s+/, $lengths);
print $small[0]; 
