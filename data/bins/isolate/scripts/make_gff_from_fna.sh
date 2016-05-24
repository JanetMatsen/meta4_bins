# Dave wrote this file, and J copied it here 5/24/2016
# Original: 
# /work/meta4_bins/data/bins/fauzi/bins/assemble_files

for file in ./bins/*.fsa
do
    gbf=`echo $file | sed "s/fsa/gbf/g"`
    organism=`head -1 $file | awk -F'=' '{ split($2, array, "("); printf("%s", array[1]); }'`
    organism=`echo $organism | sed "s/ /_/g"`
    mv $file "./bins/$organism.fasta"
    mv $gbf "./bins/$organism.genbank"
    java -jar /work/software/readseq/readseq.jar -inform=genbank -format=gff "./bins/$organism.genbank"
    mv "./bins/$organism.genbank.gff" "./bins/$organism.gff"
done
