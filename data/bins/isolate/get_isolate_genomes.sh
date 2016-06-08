mkdir bins

# Old way: 
# cp /work/dacb/extract_isolates/*.fasta ./bins
# New way: 

# see /work/meta4_bins/janalysis/virtualenv for info about virtualenv
source activate m4_janalysis

# copy the files from dave's folder, where he broke them apart
echo "copy the bins over"
rm -r ./bins
mkdir bins
cp /work/dacb/extract_isolates/*.fasta ./bins
# TODO: copy over the genbank files
# cp /work/dacb/extract_isolates/*.genbank ./bins

# TODO: make the .gff once I get the genbank broken apart and moved over. 
# echo "make .gff for each fasta"
# # Make a .gff file for each fasta:
# ./scripts/make_gff_from_genbank.sh


