# ORIGINAL_STORAGE="bins_pre_renaming"  # <-- Don't do dir name in quotes!!
ORIGINAL_STORAGE=bins_pre_renaming
mkdir $ORIGINAL_STORAGE


# archive the original zipped files if they are not already in the archive dir.
archive_original () {
    filename=$1
    dir=$2
    if [ -f "${dir}/$filename" ];
    then
       echo "File $filename exists; do not make a copy."
    else
       echo "File $filename does not exist; save a copy."
       cp $filename ./${ORIGINAL_STORAGE}
    fi
}

sub_string () {
    file_prefix=$1
    OLD_NAME=$2
    NEW_NAME=$3
    echo "---------- substiute $OLD_NAME for $NEW_NAME in files with prefix $file_prefix ----------"
    # Loop over all the files with that prefix:

    echo "Loop over files having IMG ID = $file_prefix"
    for in_file in "$file_prefix"*; do 
        echo "IN_FILE value for loop: $in_file"

        # save original if it isn't already in the archive
        archive_original $in_file $ORIGINAL_STORAGE
       
        # unzip the file
        gunzip $in_file
        unzipped_name="${in_file%.gz}"
        #ls -l $unzipped_name
        echo "unzipped_name: $unzipped_name"

        # confirm old name exists
        #ag "$OLD_NAME" "$unzipped_name" | head -n 1

        # awk to substitute in NEW_NAME
        echo "change $OLD_NAME to $NEW_NAME in $unzipped_name"	    
        echo "sed -i -- "s/${OLD_NAME}/${NEW_NAME}/g" $unzipped_name"
        # need double quotes for sed in loop!  (not true at command line)
        sed -i -- "s/${OLD_NAME}/${NEW_NAME}/g" $unzipped_name

        # ag for remaining instances of the string
        #ag "$OLD_NAME" "$unzipped_name" | head -n 1
        ag "$NEW_NAME" "$unzipped_name" | head -n 1
        echo "re-zip $unzipped_name"
        gzip "$unzipped_name"
        done
}

# Correct duplicate name:            
    # IMG Taxon ID = 2634166240
    # broken string =                   Methylotenera mobilis-49
    # replacement string =              Methylotenera mobilis-49-1
    # GOLD Analysis Project ID =        Ga0081627
    # Analysis Project Name Prefix =   
    # new name =                        Methylotenera mobilis-49 (UID3888)
    # url = https://gold.jgi.doe.gov/analysis_projects?id=Ga0081627
sub_string 2634166240 "Methylotenera mobilis-49" "Methylotenera mobilis-49-1"

# Correct duplicate name:
    # IMG Taxon ID = 2634166242
    # broken string =                   Methylotenera mobilis-49
    # replacement string =              Methylotenera mobilis-49-2
    # GOLD Analysis Project ID =        Ga0081629
    # Analysis Project Name Prefix = 
    # new name =                        Methylotenera mobilis-49 (UID203)
    # url = https://gold.jgi.doe.gov/analysis_projects?id=Ga0081629
sub_string 2634166242 "Methylotenera mobilis-49" "Methylotenera mobilis-49-2"

# Correct duplicate name:
    # IMG Taxon ID = 2634166238
    # broken string = Opititae
    # replacement string = Opitutae
    # GOLD Analysis Project ID = Ga0081625
    # Analysis Project Name Prefix = Opititae-40 (UID2982)
    # new name = Opitutae-40 (UID2982)
    # url = https://gold.jgi.doe.gov/analysis_projects?id=Ga0081625
sub_string 2634166238 Opititae Opitutae

# Correct duplicate name:
    # IMG Taxon ID = 2634166269  
    # broken string = Methylobacte-98r
    # replacement string = Methylobacter-98
    # GOLD Analysis Project ID = Ga0081657
    # Analysis Project Name Prefix = Methylobacte-98r (UID4274)
    # new name = Methylobacter-98 (UID4274)
    # url = https://gold.jgi.doe.gov/analysis_projects?id=Ga0081657
sub_string 2634166269 Methylobacte-98r Methylobacter-98

# Correct duplicate name:
    # IMG Taxon ID = 2634166257
    # broken string = Acidovora-69x
    # replacement string = Acidovorax-69
    # GOLD Analysis Project ID = Ga0081644
    # Analysis Project Name Prefix = Acidovora-69x (UID4105) 
    # new name = Acidovorax-69 (UID4105)
    # url = https://gold.jgi.doe.gov/analysis_projects?id=Ga0081644
sub_string 2634166257 Acidovora-69x Acidovorax-69 

			
			
