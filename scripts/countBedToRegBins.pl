#/usr/bin/perl -w

#######################################################
#
#	Dave Gerrard, University of Manchester
#	2011
#
######################################################


#used to 

# Usage
unless(@ARGV==4) {
   die("USAGE: $0 | Input  bed file (one chromosome, pre-sorted) | genome table | bin size | Output file  \n",
       "\n\n");
}




my $file = $ARGV[0];
my $genomeTableFile = $ARGV[1];
my $outputFile = $ARGV[3];
my $binSize = $ARGV[2];
my $firstLine = 1;
my $fileChr = '';
my $binStart = 0 ;
my $binEnd = $binSize ;
my $binCount = 0;
my $chromEnd;

open(GENOME,"<$genomeTableFile") or die "failed to open $genomeTableFile\n";

my %chrLengthHash = ();

while (<GENOME>) {
	my $line = $_;
	chomp($line) ;
	my ($chromName,$chromLength) = split(/ /,$line);
	$chrLengthHash{$chromName} = $chromLength ;
}

close(GENOME);


open (INPUT,"<$file") or die "failed to open $file\n";
open (OUTPUT,">$outputFile") or die "failed to open $outputfile\n";
while  (<INPUT>) {
	my $line = $_;
	if($line=~/(^\s|^#|^track)/) { next; }
        chomp($line);
	my($chr, $start, $end) = '';
	($chr, $start, $end) = split(/\t/, $line);
	if($firstLine)  {
		$fileChr = $chr ;
		$chromEnd = $chrLengthHash{$fileChr} ;
		$firstLine = 0;
		#print "FirstLine Encountered. $chr has length $chromEnd\n"; 
	}
	# check that the reads are all from one chromosome
	if($fileChr != $chr) { die "more than one chromosome $fileChr / $chr \n"; }
	# check that the reads does not extend beyond the end of the chromosome. 

	# check if this read is outside of this bin and if so, output counts and reset
	
	# output all empty bins between last and this read.
	while($binEnd < $start)  {
		print OUTPUT "$fileChr\t$binStart\t$binEnd\t$binCount\n" ;
		$binStart = $binStart + $binSize;
		$binEnd = $binEnd + $binSize;
		$binCount = 0;
	}
	# read must be within this bin

	$binCount = $binCount +1; 

	# add to counts

	#if ($line =~ / /) {
	#	print "";
	#}
}

#output the final read-containing bin and all subsequent bins.

while($binEnd < $chromEnd)  {
                print OUTPUT "$fileChr\t$binStart\t$binEnd\t$binCount\n" ;
                $binStart = $binStart + $binSize;
                $binEnd = $binEnd + $binSize;
                $binCount = 0;
}

if($binEnd >= $chromEnd)  {
        $binEnd = $chromEnd ;
	print OUTPUT "$fileChr\t$binStart\t$binEnd\t$binCount\n" ;
}


close(INPUT);
close(OUTPUT);
