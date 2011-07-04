#! /usr/bin/perl -w

###################################################
#
#       Dave Gerrard, University of Manchester
#       2011
#
###################################################

#Get bins of N bp either side of a coordinate, e.g. TSS
#Ian Donaldson Jan 2011
# This Version to read start and end coordinates from a bed file and count (DG)

# Usage
unless(@ARGV==3) {
   die("USAGE: $0 | Input feature bed file | bigWig file | Output  \n",
       "\n\n");
}

#my $binSize = $ARGV[3];
#chomp($binSize);

# Files
open(INPUT, "<$ARGV[0]") or die("Could not open input file!\n\n");
open(OUTPUT, ">$ARGV[2]") or die("Could not open outout file!\n\n");



#### Create bin ranges for each feature in file

# feature list 
while(defined(my $line = <INPUT>)) {
   #my @feature_list = ();

   # skip lines starting with comments,  blank lines, or 'track'
   if($line=~/(^\s|^#|^track)/) { next; }
	chomp($line);
   my($chr, $start, $end) = '';
	#print "The line: $line Hmmm \t" ;
   ($chr, $start, $end) = split(/\t/, $line);
	#print "$chr\t$start\t$end" ;
	chomp($end) ;

	#print "$chr\n" ;
	#print "$start\n";
	#print "$end\n";
   # Upstream bins
   #foreach my $bin_start (@us_bins) {
      #my $start = $coord - $binSize;
      #my $end = $coord + $binSize;
	#print("bigWigToBedGraph -chrom=$chr -start=$start -end=$end $ARGV[1] $$.temp.1\n") ;
      # run bigWigToBedGraph
	#system("bigWigToBedGraph", "-chrom=chr11", "-start=10000",  "-end=300000", "data/bigwig_files/BI.Adult_Liver.H3K27me3.3.bw", "$$.temp.1");      
	#my $call = 'bigWigToBedGraph' . ' -chrom=' . $chr .  ' -start=' . $start .  ' -end=' . $end . ' $ARGV[1]' .  "$$.temp.1" ;
	#print "$call\n" ;
	system("bigWigToBedGraph -chrom=$chr  -start=$start -end=$end $ARGV[1] $$.temp.1");
	#system("bigWigToBedGraph", "-chrom=$chr",  "-start=$start",  "-end=$end", "$ARGV[1]" ,"$$.temp.1");
      # run awk to get tally of temp file, if there was no match then call it zero
      if(-z "$$.temp.1") {
         # add 0 match to list
         #push(@feature_list, 0);
        print OUTPUT "$chr\t$start\t$end\t0\n" ; 
	next;
      }

      # awk to tally
      system("awk '{tally+=\$4} END {print tally}' $$.temp.1 > $$.temp.2");

      # read from awk result
      open(TEMP, "<$$.temp.2");
      my $tally = <TEMP>;
      chomp($tally);

	print OUTPUT "$chr\t$start\t$end\t$tally\n" ;
      # add tally to list
      #push(@feature_list, $tally);
      
      close(TEMP);

      # remove temp files
      system("rm $$.temp.1 $$.temp.2");
  # }
}  
# Close
close(INPUT);
close(OUTPUT);

exit;


