import glob
import re
import subprocess

from Bio import SeqIO

def get_original_paths():
    genbank_path_list = glob.glob("./originals/genbank/*.gbf")
    fasta_path_list = glob.glob("./originals/fasta/*.fsa")
    return genbank_path_list, fasta_path_list 


def file_name_from_genbank_description(name):
    """
    Acidovorax-127 (UID4105), whole genome shotgun sequence." --> Acidovorax-127 
    """
    # Note that the - in the brackets has to come at the end. 
    m = re.search("([\w\s-]+) \([\w]+\), [\w.]+", name)
    if m:
        return m.group(1)
    else:
        return "???"


def file_name_from_fasta_description(name):
    """
    Ga0081612_1001 [organism=Methylophilus methylotrophus-127-2 (UID203)] [tech=wgs] [topology=linear] [gcode=11] [completedness=partial] [project=0]
    --> Methylophilus_methylotrophus-127-2
    """
    # Note that the - in the brackets has to come at the end. 
    m = re.search("[\w_]+ \[organism=([\w\s-]+) \([\w]+\)\]", name)
    if m:
        return m.group(1)
    else:
        return "???"
    

def new_genbank_name(genbank_path):
    seq_records = SeqIO.parse(genbank_path, "genbank")
    # seq_records is a generator.  Just use the first one.
    for seq_record in seq_records:
        print(seq_record.description)
        new_name = file_name_from_genbank_description(seq_record.description)
        # we don't actually want to loop over the rest, so break out
        break
    # replace spaces with _:
    new_name = new_name.replace(" ", "_")
    return new_name


def new_fasta_name(fasta_path):
    seq_records = SeqIO.parse(fasta_path, "fasta")
    for seq_record in seq_records:
        print(seq_record.description)
        new_name = file_name_from_fasta_description(seq_record.description)
        # we don't actually want to loop over the rest, so break out
        break
    # replace spaces with _:
    new_name = new_name.replace(" ", "_")
    print("new name for {}: {}".format(fasta_path, new_name))
    return new_name


def copy_genbank_with_new_name(genbank_path):
    new_path = "./bins/" + \
         new_genbank_name(genbank_path) + '.gbf'
    print("copying {} to {}".format(genbank_path, new_path))
    subprocess.check_call(['cp', genbank_path, new_path])


def copy_fasta_with_new_name(fasta_path):
    new_path = "./bins/" + new_fasta_name(fasta_path) + '.fsa'
    print("copying {} to {}".format(fasta_path, new_path))
    subprocess.check_call(['cp', fasta_path, new_path])


def copy_all_files():
    genbank_path_list, fasta_path_list = get_original_paths()    
    for gbf in genbank_path_list:
        copy_genbank_with_new_name(gbf)
    for fna in fasta_path_list:
        copy_fasta_with_new_name(fna)


if __name__ == "__main__":
    print('running script')
    copy_all_files()



