genome_bins.fasta
genome_bins.gbk

preprocess_input

# the GFF3 file for the scaffolds
genome_bins.gff
# this generates the gff from the gbk using bioperl
setup_genes_table

# order of operations:
./preprocess_input
./setup_genes_table
