mkdir bins

# Old way: 
# cp /work/dacb/extract_isolates/*.fasta ./bins
# New way: 

# see /work/meta4_bins/janalysis/virtualenv for info about virtualenv
source activate m4_janalysis

# copy the files from ./originals/ with better names
echo "copy the bins over"
python prepare_bins.py

echo "make .gff for each fasta"
# Make a .gff file for each fasta:
./make_gff_from_fna.sh


