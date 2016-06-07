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
    file_dest=./bins/$organism.fasta
    echo "move $file to $file_dest"
	mv $file $file_dest
    echo "move genbank ($gbf) to ./bins/$organism.genbank"
	mv $gbf ./bins/$organism.genbank
	java -jar /work/software/readseq/readseq.jar -inform=genbank -format=gff ./bins/$organism.genbank
	mv ./bins/$organism.genbank.gff ./bins/$organism.gff
done
