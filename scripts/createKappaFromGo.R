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

if(length(Args) != 2)  { 
	stop("Usage: empR.R [GO map] [outFile]\n
		Create kapppa matrix of annotation similarity based on GO map.
	")
	
}

inFileName <- Args[1]
outFileName <- Args[2]

# prep and dependencies
#source("http://www.bioconductor.org/biocLite.R")
#biocLite("graph")
#biocLite("topGO")

library("topGO")
prot2go <-  readMappings(inFileName)

fullProtList <- names(prot2go)
#protTerms <- prot2go[fullProtList]
fullTermList <- unique(as.character(unlist(prot2go)))



	binaryGrid <- matrix(0,nrow=length(fullProtList),ncol=length(fullTermList),dimnames=list(fullProtList,fullTermList))

	##binaryGrid["P61604",as.character(unlist(prot2go["P61604"]))] <- 1

	##possible to do this without FOR loop?
	for(i in 1:length(fullProtList))  {
		binaryGrid[fullProtList[i],as.character(unlist(prot2go[fullProtList[i]]))] <- 1
	}


	### create kappa matrix for genes against genes based on co-occurrence of terms
	## can eliminate genes with <4 (minTermSize) terms. 

	#number of terms per protein
	termCounts <- rowSums(binaryGrid)

	#contTable <- table(binaryGrid[37,],binaryGrid[38,])[c(2:1),c(2:1)]
	#contTable <- table(binaryGrid[1,],binaryGrid[2,])[c(2:1),c(2:1)]
	#contTable <- table(binaryGrid[1,],binaryGrid[1,])[c(2:1),c(2:1)]

	davidKappaFromTable <- function(contTable)  {

		obs <- (contTable[1,1] + contTable[2,2]) / sum(contTable)
		exp <- (rowSums(contTable)[1] * colSums(contTable)[1] + rowSums(contTable)[2] * colSums(contTable)[2])/ sum(contTable)^2
		davidKappa <- (obs - exp) / (1-exp)
	}
#	(as.numeric(davidKappaFromTable(contTable)))


	#### THIS IS SLOW! About 30 mins. have saved the table
	kappaMatrix <-matrix(0,nrow=nrow(binaryGrid),ncol=nrow(binaryGrid),dimnames=list( row.names(binaryGrid), row.names(binaryGrid)))
	for(i in 1:nrow(kappaMatrix))  {
		for(j in 1:nrow(kappaMatrix)) {
			contTable <- table(binaryGrid[i,],binaryGrid[j,])[c(2:1),c(2:1)]
			kappaMatrix[i,j] <- as.numeric(davidKappaFromTable(contTable))
		}
	}


	write.table(kappaMatrix, file="data/ubiAllProtsKappaMatrix.tab",quote=F,sep="\t")




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
