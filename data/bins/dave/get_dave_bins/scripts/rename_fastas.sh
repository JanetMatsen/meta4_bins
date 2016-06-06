DEST_DIR='../bins/'

echo "--- Move files in DEST_DIR: $DEST_DIR ---"
for file in $DEST_DIR*.fna; do
    echo $file
    NEWNAME="${file/%.fna/.fasta}"
    echo "New fasta name: $NEWNAME"
    mv $file $NEWNAME
done
