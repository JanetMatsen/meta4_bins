# Script to loop over all of the bins. 
# store their names and paths to their fasta and gff files.
import glob
import os
import re

import pandas as pd

fasta_paths = list(glob.iglob('./*/bins/*.fasta', recursive=True))
# append on Dave's, which end with .fna
fasta_paths += list(glob.iglob('./*/bins/*.fna', recursive=True))

print("number of fasta paths found: {}".format(len(fasta_paths)))

def build_summary_table():
    bin_info_dicts = []
    for filepath in fasta_paths:
        full_path = os.path.abspath(filepath)
        info_dict = {'fasta path' : full_path}
        # assume there is an equally named file but .gff
        info_dict['gff path'] = info_dict['fasta path'].rstrip('fasta') + 'gff'

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

    # copy a version of this to /work/meta4_bins/job_manager as bins.tsv
    summary_table_2.to_csv('/work/meta4_bins/job_manager/bins.tsv', sep='\t', index=False)