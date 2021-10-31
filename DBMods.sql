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

