# Script to loop over all of the bins. 
# store their names and paths to their fasta and gff files.
import glob
import os
import re

import pandas as pd

fasta_paths = glob.glob('./*/bins/*.fasta')
# append on Dave's, which end with .fna
fasta_paths += glob.glob('./*/bins/*.fna')

print("number of fasta paths found: {}".format(len(fasta_paths)))

def build_summary_table():
    bin_info_dicts = []
    for filepath in fasta_paths:
        # get the full path from glob:
        full_path = os.path.abspath(filepath)
        # e.g. /work/meta4_bins/data/samples/LakWasMeta1_LOW4_2/Raw_Data/8904.1.115212.CGATGT.fastq.gz
        info_dict = {'fasta path' : full_path}

        # assume there is an equally named file but .gff
        if ".fasta" in info_dict['fasta path']:
            info_dict['gff path'] = info_dict['fasta path'].rstrip('fasta') + 'gff'
        elif ".fna" in info_dict['fasta path']:
            info_dict['gff path'] = info_dict['fasta path'].rstrip('fna') + 'gff'
        # assert that this file exists:
        # TODO: take off this "if" that prevents checking of isolates. 
        # Requires copying the isolates over for good. 
        if "isolate" not in full_path:
            assert os.path.isfile(info_dict['gff path']), \
                "file {} doesn't exist!".format(info_dict['gff path'])
        

        # get the name of the bin
        file_name = os.path.basename(filepath)
        info_dict['name'] = file_name
        info_dict['name'] = os.path.splitext(file_name)[0]
        #info_dict['bin category'] = \
        #    re.search('/([a-z]+)/bins/', filepath).group(1)
        bin_info_dicts.append(info_dict)
    return pd.DataFrame(bin_info_dicts)


if __name__ == "__main__":
    summary_table = build_summary_table()
    summary_table.head()
    # trick to get columns in order:
    summary_table_2 = summary_table[['name', 'fasta path', 'gff path']]
    summary_table_2.to_csv('bin_summary_table.tsv',
                         sep='\t', index=False)
    
    summary_table_2.head(3)

    # copy a version of this to /work/meta4_bins/job_manager as bins.tsv
    summary_table_2.to_csv('/work/meta4_bins/job_manager/bins.tsv', sep='\t', index=False)
