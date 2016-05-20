DROP TABLE IF EXISTS job;

DROP TABLE IF EXISTS sample;
CREATE TABLE sample (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name TEXT,
	fastq_path	TEXT
);

DROP TABLE IF EXISTS bin;
CREATE TABLE bin (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name TEXT,
	fasta_path	TEXT,
	gff_path	TEXT
);

DROP TABLE IF EXISTS status;
CREATE TABLE status (
	id INT PRIMARY KEY AUTO_INCREMENT,
	status_text VARCHAR(128)
);

INSERT INTO status (status_text) VALUES ("Cataloged");
INSERT INTO status (status_text) VALUES ("Running");
INSERT INTO status (status_text) VALUES ("Complete");

CREATE TABLE job (
	id	INT PRIMARY KEY AUTO_INCREMENT,
	sample_id	INT NOT NULL,
	bin_id	INT NOT NULL,
	status_id INT NOT NULL,
	FOREIGN KEY (sample_id) REFERENCES sample(id),
	FOREIGN KEY (bin_id) REFERENCES bin(id),
	FOREIGN KEY (status_id) REFERENCES status(id)
);

CREATE VIEW jobs AS
	SELECT job.id, 
			sample.name AS sample_name, sample.fastq_path AS sample_fastq_path, 
			bin.name AS bin_name, bin.fasta_path AS bin_fasta_path, bin.gff_path AS bin_gff_path,
			status.status_text
		FROM
			job
			INNER JOIN sample ON sample.id = job.sample_id
			INNER JOIN bin ON bin.id = job.bin_id
			INNER JOIN status ON status.id = job.status_id
		ORDER BY sample.id
	;

LOAD DATA LOCAL INFILE 'bins.tsv' INTO TABLE bin FIELDS TERMINATED BY '\t' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE 'samples.tsv' INTO TABLE sample FIELDS TERMINATED BY '\t' IGNORE 1 LINES;
