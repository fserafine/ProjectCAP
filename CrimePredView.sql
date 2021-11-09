CREATE VIEW 
    crimepred 
AS

SELECT
    i.incident_id as "Incident ID",
    o.offense_id as "Offense ID",
	vo.victim_id as "Victim ID",
	od.offender_id as "Offender ID",
    i.incident_date as "Date",
    i.incident_hour as "Hour",
    ot.offense_name as "Offense",
    o.attempt_complete_flag as "Attempted or Completed",
    od.age_num as "Offender Age",
    od.sex_code as "Offender Gender",
    od.race as "Offender Race",
    bl.bias_name as "Offender Bias",
    wt.weapon_name as "Weapon",
    vt.victim_type_name as "Victim Type",
    rel.relationship_name as "Relation to Offender",
    v.age_num as "Victim Age",
    v.sex_code as "Victim Gender",
    v.race as "Victim Race"
FROM
    nibrs_incident i
LEFT JOIN nibrs_victim v ON i.incident_id = v.incident_id
LEFT JOIN nibrs_victim_offense vo ON v.victim_id = vo.victim_id
LEFT JOIN nibrs_victim_offender_rel vor ON v.victim_id = vor.victim_id
LEFT JOIN nibrs_victim_type vt ON v.victim_type_id = vt.victim_type_id
LEFT JOIN nibrs_relationship rel ON vor.relationship_id = rel.relationship_id
INNER JOIN nibrs_offense o ON vo.offense_id = o.offense_id
INNER JOIN nibrs_offense_type ot ON o.offense_type_id = ot.offense_type_id
INNER JOIN nibrs_offender od ON o.incident_id = od.incident_id
LEFT JOIN nibrs_weapon w ON o.offense_id = w.offense_id
LEFT JOIN nibrs_weapon_type wt ON w.weapon_id = wt.weapon_id
LEFT JOIN nibrs_bias_motivation b ON o.offense_id = b.offense_id
LEFT JOIN nibrs_bias_list bl ON b.bias_id = bl.bias_id

UNION ALL

SELECT
    i.incident_id as "Incident ID",
    o.offense_id as "Offense ID",
	vo.victim_id as "Victim ID",
	od.offender_id as "Offender ID",
    i.incident_date as "Date",
    i.incident_hour as "Hour",
    ot.offense_name as "Offense",
    o.attempt_complete_flag as "Attempted or Completed",
    od.age_num as "Offender Age",
    od.sex_code as "Offender Gender",
    od.race as "Offender Race",
    bl.bias_name as "Offender Bias",
    wt.weapon_name as "Weapon",
    vt.victim_type_name as "Victim Type",
    rel.relationship_name as "Relation to Offender",
    v.age_num as "Victim Age",
    v.sex_code as "Victim Gender",
    v.race as "Victim Race"
FROM
    nibrs_incident_addl i
LEFT JOIN nibrs_victim_addl v ON i.incident_id = v.incident_id
LEFT JOIN nibrs_victim_offense_addl vo ON v.victim_id = vo.victim_id
LEFT JOIN nibrs_victim_offender_rel_addl vor ON v.victim_id = vor.victim_id
LEFT JOIN nibrs_victim_type vt ON v.victim_type_id = vt.victim_type_id
LEFT JOIN nibrs_relationship rel ON vor.relationship_id = rel.relationship_id
INNER JOIN nibrs_offense_addl o ON vo.offense_id = o.offense_id
INNER JOIN nibrs_offense_type ot ON o.offense_type_id = ot.offense_type_id
INNER JOIN nibrs_offender_addl od ON o.incident_id = od.incident_id
LEFT JOIN nibrs_weapon_addl w ON o.offense_id = w.offense_id
LEFT JOIN nibrs_weapon_type wt ON w.weapon_id = wt.weapon_id
LEFT JOIN nibrs_bias_motivation_addl b ON o.offense_id = b.offense_id
LEFT JOIN nibrs_bias_list bl ON b.bias_id = bl.bias_id