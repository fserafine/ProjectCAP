-- Add race column to bring in demographic information to victims and offenders

ALTER TABLE nibrs_victim ADD COLUMN race text;
ALTER TABLE nibrs_victim_addl ADD COLUMN race text;
ALTER TABLE nibrs_offender ADD COLUMN race text;
ALTER TABLE nibrs_offender_addl ADD COLUMN race text;

UPDATE nibrs_victim
    SET race = 
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

-- Format the incident_date from nibrs_incident to drop the empty HH:MM:SS values

UPDATE nibrs_incident
    SET incident_date = 
        DATE(incident_date);