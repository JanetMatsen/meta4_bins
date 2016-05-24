import os
import re
import sys

import glob

def abs_path_from_rel_path(file_path):
    return os.path.abspath(file_path)


def file_name_from_path(file_path):
    # e.g. get from  LakWasMeta9_HOW4
    # /work/meta4_bins/data/samples/LakWasMeta9_HOW4_2/Raw_Data/8904.1.115212.GATCAG.fastq.gz 
    # \w means [a-zA-Z0-9_]
    m = re.search('/work/meta4_bins/data/samples/([\w]+_2)/Raw_Data/[\.\w]+.fastq.gz', file_path) 
    #print(m.group(1))
    if m:
        sample_name = m.group(1)
        return sample_name
    else:
        return "???"


if __name__ == "__main__":
    with open('samples.tsv', 'w') as f:
        f.write("#sample" + "\t" + "fastq" + "\n")
    with open('samples.tsv', 'a') as f:
        for file_path in glob.glob("../data/samples/*/Raw_Data/*.fastq.gz"):
            abs_path = abs_path_from_rel_path(file_path)
            file_name = file_name_from_path(abs_path)
            f.write(file_name + "\t" +  abs_path + "\n")

