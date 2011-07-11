#!/usr/bin/Rscript

#######################################################
#
#       Dave Gerrard, University of Manchester
#       2011
#
######################################################


########FUNCTIONS


###########################################

# plan to be able to call this script thus: Rscript script.R arg1 arg2 ..
# get args from call
Args <- commandArgs(TRUE)

if(length(Args) != 4)  { 
	stop("Usage: bindGenomeBinCounts.R [dir] [pattern] [sample info] [output file]\n
		Given a directory [dir], opens all binCount files matching [pattern] and 
		binds their count values into one table. Writes to [output file]. All binCount
		files must have identical feature locations. Form: chr	start	end	count
		Information about each file must be provided in [sample info]
	")
	
}




old.o <- options(scipen=999)           # need to disable scientific notation for large genome coordinates. Restore options at end of script.

### H3K4me3, H3K27me3. 8 tissue samples (some duplicates)
### pdx1 (pancreatic fate determination) is on chr13 (NOT chr11!)


setwd("output/binCounts/")
print(getwd())
countFiles <- dir(pattern="binCounts", full.names=T)
#chrom specific files have names like:-
# GSM669625_UCSF-UBC.Fetal_Brain.H3K27me3.HuFNSC-T.chr11.1000.binCounts
# but these are not perfectly structured. Cannot use strsplit()
#sampleInfo <- data.frame(rawName=basename(countFiles))
#sampleInfo$h_mark <- NA
#write.table(basename(countFiles),file="sampleNames.txt", quote=F, row.names=F, col.names=F)

# I have made a file with sampleInfo for this test
sampleInfo <- read.delim("sampleInfo.tab", header=T)
sampleInfo$niceName <- paste(sampleInfo$hMark, sampleInfo$Tissue, sampleInfo$individual, sep=".")

print(Args)
#stopifnot(FALSE)

#thisCount <- read.delim(countFiles[1], header=F, as.is=T)
#thisCount.2  <- read.delim(countFiles[2], header=F)


allCounts <- data.frame()
for (i in 1:length(countFiles))  {
	thisCount <- read.delim(countFiles[i], header=F)
	if(i==1) {
		prototype <- thisCount[,1:3]
		allCounts <- prototype
		names(allCounts) <- c("chr", "start", "end")
	} else {
		# chr start and end of each file should be identical 
		stopifnot(identical(thisCount[,1:3], prototype[,1:3]))
	}
	allCounts[,basename(countFiles[i])] <- thisCount[,4]
}

names(allCounts)[4:19] <- sampleInfo$niceName

write.table(allCounts, file=Args[4], quote=F, sep="\t", row.names=F)

quit(save="no")

############SAMPLE CODE
#old.o <- options(scipen=999)		# need to disable scientific notation for large genome coordinates. Restore options at end of script.
# is the input non-overlapping
# may need to get chrom.sizes from assembly.
# keep spaces and lengths together?  Currently yes.
#file_name <- Args[1]
#linesToSkip <- Args[2]
# does the file have a header list?

#feature_list <- read.delim(file_name,header=F,comment.char="#",skip=linesToSkip)
#names(feature_list)[c(1,2,3)] <- c("chr","start","end")
#print(levels(feature_list$chr))
#feature_list$length <- feature_list$end - feature_list$start
#cat(c(Args[1],nrow(feature_list),sum(feature_list$length),"\n"),sep="\t")
#options(old.o)	#restore options.
