./setup_database
./jobs_from_lst
./job_setup
./run_jobs

setup_database:
    Uses setup_database.sql to create SQL tables: sample, bin, status,  
    Creates a job table (to track info about the bin/sample pair and its status (complete or not?)) 
    Creates a view called jobs, which joins all the other tables together 
    Loads bins.tsv, samples.tsv into the apporpriate tables. 
jobs_from_lst
    Uses a list of jobs (jobs.lst) to populate the job SQL table
    Also uses sample_meta_info.tsv to match strings like LakWasMeta to IDs like 73_LOW10
job_setup
    Makes PBS files, and scripts for each of the jobs that need to be run
    e.g. makes samtools(.sh), 
    Makes a database dir using each sample number. 
run_jobs
    Uses gnu parallel to run jobs

