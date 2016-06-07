#!/bin/bash

# make bin dir
mkdir -p bins

cp ./raw/genome_bins/*.fsa.gz ./raw/genome_bins/*.gbf.gz ./bins
gunzip -f ./bins/*.fsa.gz ./bins/*.gbf.gz

for file in ./bins/*.fsa
do
	gbf=`echo $file | sed "s/fsa/gbf/g"`
	organism=`head -1 $file | awk -F'=' '{ split($2, array, "("); printf("%s", array[1]); }'`
	organism=`echo $organism | sed "s/ /_/g"`
	mv $file ./bins/$organism.fasta
	mv $gbf $organism.genbank
	#java -jar /work/software/readseq/readseq.jar -inform=genbank -format=gff $organism.genbank
	#mv $organism.genbank.gff $organism.gff
done
