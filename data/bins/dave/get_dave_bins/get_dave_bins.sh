#!/usr/bin/env bash

# change current directory to that of script
cd "$(dirname "$0")"

# bins are stored at :
# /work/dacb/elvizAnalysis/results/
# there s .gff, .fna, .dat

# the favorite bins (540 of them) were e-mailed to Janet on 5/10
# Janet saved them locally, moved a copy in .tsv format via sshfs, and is grabbing them from /work/dacb/elvizAnalysis/.

BIN_NAMES=`awk 'NR>1 {print $1}' 160510_interesting_bins_dave_made.tsv` 
#echo $BIN_NAMES
PATH_TO_BINS="/work/dacb/elvizAnalysis/results/"

# keep track of bins we couldn't find (shouldn't be any)
MISSING_BINS=""
MISSING_GFFS=""

# prepare a folder to keep them in
DEST_DIR='../bins/'
echo "make directory to store copies of bins: $DEST_DIR"
mkdir -p $DEST_DIR
rm -rf $DEST_DIR/*

# Grab them one by one
for BIN in $BIN_NAMES
do 
  BIN_PATH="${PATH_TO_BINS}${BIN}.fna"
  #ls -l $BIN_PATH
  # echo "copy $BIN_PATH to $DEST_DIR"
  # -r is readable, -e is exists
  if [ ! -r $BIN_PATH ]
  then
      MISSING_BINS="${MISSING_BINS} ${BIN_PATH}"
      echo unable to read file $BIN_PATH
  # check that the file you are about to move doesn't exist at the destination
  else
    DEST_FILE="${DEST_DIR}${BIN}.fna"
    if [ -e $DEST_FILE ]
    then
        echo "file $DEST_FILE already exists"
    else
        cp $BIN_PATH $DEST_DIR
    fi
  fi

  # also copy the genbank file
  GFF_PATH="${BIN_PATH/%.fna/.gff}"
  # echo "also copy over $GFF_PATH"
  if [ ! -r $GFF_PATH ]
  then
      MISSING_GFFS="${MISSING_GFFS} ${GFF_PATH}"
      echo unable to read file $GFF_PATH
  else
    DEST_FILE="${DEST_DIR}${BIN}.gff"
    if [ -e $DEST_FILE ]
    then
        echo "file $DEST_FILE already exists"
    else
        cp $GFF_PATH $DEST_DIR
    fi
  fi
done

echo "missing bins:"
echo $MISSING_BINS

echo "missing gff:"
echo $MISSING_GFFS

# Check the number of bins retreived: 
NUM_FILES_MOVED=`ls $DEST_DIR | wc -l`
echo "number of files in ${DEST_DIR}: $NUM_FILES_MOVED"

# subtract 1 for the header
NUM_FILES_EXPECTED=`grep -v Bin 160510_interesting_bins_dave_made.tsv | wc -l`
# expect a .fasta file and a .gff file for each. 
NUM_FILES_EXPECTED=`expr $NUM_FILES_EXPECTED \* 2`
echo "number of files expected: $NUM_FILES_EXPECTED"

