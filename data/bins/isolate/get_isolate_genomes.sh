mkdir bins

# Old way: 
# cp /work/dacb/extract_isolates/*.fasta ./bins
# New way: 

# see /work/meta4_bins/janalysis/virtualenv for info about virtualenv
source activate m4_janalysis

python prepare_bins.py


