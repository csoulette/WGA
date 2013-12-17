#Usage: Takes show-coords -bHt out.delta > output and formats it for mutli genome synteny viewer
# http://cas-bioinfo.cas.unt.edu/mgsv/index.php

print "#org1\torg1_start\torg1_end\torg2\torg2_start\torg2_end\tscore\tevalue\n";
while (<>) {
    @d = split;

    $fixed = "$d[6]\t$d[2]\t$d[3]\t$d[7]\t$d[0]\t$d[1]\t0\t000";
    print $fixed . "\n";
}
