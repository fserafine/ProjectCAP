-- Add race column to bring in demographic information to victims and offenders

-- COME BACK AND MAKE ALL THESE SQL LINES INDENTED LIKE THE FOLLOWING:

ALTER TABLE 
    nibrs_victim 
ADD COLUMN 
    race text;
ALTER TABLE 
    nibrs_victim_addl 
ADD COLUMN 
race text;
ALTER TABLE 
    nibrs_offender 
ADD COLUMN 
    race text;
ALTER TABLE 
    nibrs_offender_addl 
ADD COLUMN 
    race text;

UPDATE 
    nibrs_victim
SET 
    race = 
        (SELECT race_desc 
        FROM ref_race 
        WHERE ref_race.race_id = nibrs_victim.race_id) 
    WHERE race_id IN 
        (SELECT race_id 
        FROM ref_race 
        WHERE ref_race.race_id = nibrs_victim.race_id);

UPDATE nibrs_victim_addl 
    SET race = 
        (SELECT race_desc 
        FROM ref_race 
        WHERE ref_race.race_id = nibrs_victim_addl.race_id) 
    WHERE race_id IN 
        (SELECT race_id 
        FROM ref_race 
        WHERE ref_race.race_id = nibrs_victim_addl.race_id);

UPDATE nibrs_offender
    SET race = 
        (SELECT race_desc 
        FROM ref_race 
        WHERE ref_race.race_id = nibrs_offender.race_id) 
    WHERE race_id IN 
        (SELECT race_id 
        FROM ref_race 
        WHERE ref_race.race_id = nibrs_offender.race_id);

UPDATE nibrs_offender_addl 
    SET race = 
        (SELECT race_desc 
        FROM ref_race 
        WHERE ref_race.race_id = nibrs_offender_addl.race_id) 
    WHERE race_id IN 
        (SELECT race_id 
        FROM ref_race 
        WHERE ref_race.race_id = nibrs_offender_addl.race_id);

-- Add ethnicity column to victim and offender info tables and populate it

ALTER TABLE 
    nibrs_victim 
ADD COLUMN 
    ethnicity text;
ALTER TABLE 
    nibrs_victim_addl 
ADD COLUMN 
ethnicity text;
ALTER TABLE 
    nibrs_offender 
ADD COLUMN 
    ethnicity text;
ALTER TABLE 
    nibrs_offender_addl 
ADD COLUMN 
    ethnicity text;

UPDATE 
    nibrs_victim
SET 
    ethnicity = 
        (SELECT ethnicity_name 
        FROM nibrs_ethnicity 
        WHERE nibrs_ethnicity.ethnicity_id = nibrs_victim.ethnicity_id) 
    WHERE ethnicity_id IN 
        (SELECT ethnicity_id 
        FROM nibrs_ethnicity 
        WHERE nibrs_ethnicity.ethnicity_id = nibrs_victim.ethnicity_id);

UPDATE nibrs_victim_addl 
    SET ethnicity = 
        (SELECT ethnicity_name 
        FROM nibrs_ethnicity 
        WHERE nibrs_ethnicity.ethnicity_id = nibrs_victim_addl.ethnicity_id) 
    WHERE ethnicity_id IN 
        (SELECT ethnicity_id 
        FROM nibrs_ethnicity 
        WHERE nibrs_ethnicity.ethnicity_id = nibrs_victim_addl.ethnicity_id);

UPDATE nibrs_offender
    SET ethnicity = 
        (SELECT ethnicity_name 
        FROM nibrs_ethnicity 
        WHERE nibrs_ethnicity.ethnicity_id = nibrs_offender.ethnicity_id) 
    WHERE ethnicity_id IN 
        (SELECT ethnicity_id 
        FROM nibrs_ethnicity 
        WHERE nibrs_ethnicity.ethnicity_id = nibrs_offender.ethnicity_id);

UPDATE nibrs_offender_addl 
    SET ethnicity = 
        (SELECT ethnicity_name 
        FROM nibrs_ethnicity 
        WHERE nibrs_ethnicity.ethnicity_id = nibrs_offender_addl.ethnicity_id) 
    WHERE ethnicity_id IN 
        (SELECT ethnicity_id 
        FROM nibrs_ethnicity 
        WHERE nibrs_ethnicity.ethnicity_id = nibrs_offender_addl.ethnicity_id);

-- Modify incident_date string from nibrs_incident_addl to be recognizable timestamp

UPDATE nibrs_incident_addl 
    SET incident_date = 
        REPLACE(incident_date, '-19', '-2019');

UPDATE nibrs_incident_addl 
    SET incident_date = 
        REPLACE(incident_date, '-18', '-2018');

UPDATE nibrs_incident_addl 
    SET incident_date = 
        REPLACE(incident_date, '-17', '-2017');

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'JAN', '01');

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'FEB', '02'); 

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'MAR', '03'); 

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'APR', '04'); 

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'MAY', '05'); 

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'JUN', '06'); 

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'JUL', '07'); 

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'AUG', '08'); 

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'SEP', '09'); 

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'OCT', '10'); 

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'NOV', '11'); 

UPDATE nibrs_incident_addl
    SET incident_date = 
        REPLACE(incident_date, 'DEC', '12'); 

UPDATE nibrs_incident_addl
    SET incident_date = 
        (SUBSTR(incident_date, 7, 10) || '-' || SUBSTR(incident_date, 4, 5) || '-' || SUBSTR(incident_date, 1, 2));

-- Remove extra 2-digit year prefix from leftover date substring text

UPDATE nibrs_incident_addl
    SET incident_date =
        REPLACE(incident_date,'20-','');

-- Format the incident_date from nibrs_incident to drop the empty HH:MM:SS values

UPDATE nibrs_incident
    SET incident_date = 
        DATE(incident_date);

-- Insert Not Applicable value for nulls in Victim Gender feature where victim is not a specific person

UPDATE 
	crimepred_ftworth 
SET 
	"Victim Gender" = 
		'Not Applicable' 
WHERE 
	"Victim Type" IN 
		('Business', 'Government', 'Religious Organization', 'Society/Public', 'Financial Institution', 'Other')
AND
	"Victim Gender" IS NULL
AND 
	"Victim Race" IS NULL
AND 
	"Victim Age" IS NULL;

-- Insert U value for nulls in Victim Gender where victim is unknown
UPDATE 
	crimepred_ftworth
SET
	"Victim Gender" = 
		'U'
WHERE
	"Victim Gender" is NULL
AND
	"Victim Age" IS NULL
AND 
	"Victim Race" =
		'Unknown';

-- Insert Not Applicable value for nulls in Victim Race where victim is not a specific person

UPDATE 
	crimepred_ftworth 
SET 
	"Victim Race" = 
		'Not Applicable' 
WHERE 
	"Victim Type" IN 
		('Business', 'Government', 'Religious Organization', 'Society/Public', 'Financial Institution', 'Other')
AND 
	"Victim Age" IS NULL
AND
    "Victim Race" IS NULL;

-- Insert Unknown value for nulls in Victim Race where victim is unknown

UPDATE
	crimepred_ftworth
SET
	"Victim Race" =
		'Unknown'
WHERE
	"Victim Type" =
		'Unknown'
AND
	"Victim Race" IS NULL;

-- Insert Relationship Unknown value for nulls in Relationship to Offender when victim is unknown, an individual, or a law enforcement officer

UPDATE
	crimepred_ftworth
SET
	"Relation to Offender" =
		'Relationship Unknown'
WHERE
	"Relation to Offender" IS NULL
AND 
	"Victim Type" IN 
		('Unknown', 'Law Enforcement Officer', 'Individual');

-- Insert Not Applicable value for nulls in Relationship to Offender when victim is an organization or society

UPDATE
	crimepred_ftworth
SET
	"Relation to Offender" =
		'Not Applicable'
WHERE
	"Relation to Offender" IS NULL
AND 
	"Victim Type" IN 
		('Business', 'Society/Public', 'Religious Organization', 'Government', 'Financial Institution', 'Other');

-- Insert None value for nulls in Weapon, as null implies no weapon used in incident

UPDATE 
	crimepred_ftworth 
SET 
	"Weapon" = 
		'None'
WHERE
	"Weapon" IS NULL;

-- Insert U value for nulls in Victim Gender where victim type is unknown

UPDATE
	crimepred_ftworth
SET
	"Victim Gender" =
		'U'
WHERE
	"Victim Gender" IS NULL
AND
	"Victim Type" =
		'Unknown';

-- Insert U value for nulls in Offender Gender where offender age, race, and gender are unknown

UPDATE 
	crimepred_ftworth
SET
	"Offender Gender" =
		'U'
WHERE
	"Offender Gender" IS NULL
AND
	"Offender Race" IS NULL
AND
	"Offender Age" IS NULL;

-- Insert Unknown value for nulls in Offender Race where offender race, gender, and age are unknown 

UPDATE
	crimepred_ftworth
SET
	"Offender Race" =
		'Unknown'
WHERE
	"Offender Race" IS NULL
AND
	"Offender Gender" =
		'U'
AND
	"Offender Age" IS NULL;

    UPDATE 
	crimepred_ftworth
SET
	"Offender Ethnicity" = 
		'Unknown'
WHERE
	"Offender Ethnicity" IS NULL;
	
UPDATE 
	crimepred_ftworth
SET
	"Victim Ethnicity" = 
		'Not Applicable'
WHERE
	"Victim Ethnicity" IS NULL
AND
	"Relation to Offender" =
		'Not Applicable';
		
UPDATE 
	crimepred_ftworth
SET
	"Victim Ethnicity" =
		'Unknown'
WHERE
	"Victim Ethnicity" IS NULL;

UPDATE
	crimepred_ftworth
SET
	"Victim Race" =
		'Not Applicable'
WHERE
	"Victim Race" =
        'Unknown'
AND
	"Relation to Offender" =
		'Not Applicable';