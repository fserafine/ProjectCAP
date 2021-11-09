# Crime Prediction with Machine Learning
## Author: Frank Serafine | Log: Exploratory Data Analysis

This logfile contains the various stages of EDA performed on the project.

---
### Stage 1: Download and Assess
---

- Data Origin: US National Incident-Based Reporting System (NIBRS)
- Data Download Source: [FBI Crime Data Explorer](https://crime-data-explorer.fr.cloud.gov/pages/downloads)
    - Subsection: "Crime Incident-Based Data by State"
- State: Texas
- Years: 2010-2019
- Glossary of CSV Column Names: [NIBRS Data Dictionary](NIBRS_DataDictionary.pdf) (Source: FBI)
- Structure of NIBRS Data: [NIBRS Diagram](nibrs_diagram.pdf) (Source: FBI)
    - This informed my creation of a unified table  '`crimepred_source`' via a series of targeted JOINs in the SQLite db.

I chose **SQLite** as the medium to store these imported CSVs for initial data wrangling, as there are 43 CSVs for each year of information. Why SQLite instead of MySQL or PostgreSQL? Because SQLite databases are smaller and can import many CSVs as tables all at once without needing to pre-create the table structures manually ahead of time.

The FBI's readme (See [NIBRS Readme.md](https://github.com/fserafine/CrimePrediction/blob/main/NIBRS_README.md)) file that is included with each year explains that 20 of the 43 CSVs from each year are code lookup tables used for retrieving codes and names and do not change from year to year. The other CSVs that change per year that were essential to this project are:

- `nibrs_incident` (1 crime incident per row)
- `nibrs_offense` (up to 10 offenses per incident)
- `nibrs_offender` (up to 99 offenders per incident)
- `nibrs_victim` (up to 999 victims per incident)
- `nibrs_victim_offense` (maps victims to offenses)
- `nibrs_victim_offender_rel` (relationship info for up to 10 offenders per victim per incident)
- `nibrs_weapon` (up to 3 weapons per offense)
- `nibrs_bias_motivation` (up to 5 bias motivations per offense)

The other CSVs present in the downloads were either redundant (categorical information further classifying categorical information) or not essential to the project goal and were not included.

### Stage 2: Import and Preprocessing in SQLite
---
Upon importing data from the starting year (2010), a preliminary look by running the following query showed that not every incident had an offense associated with it:
``` sql
SELECT * 
FROM nibrs_incident 
WHERE incident_id 
NOT IN 
    (SELECT incident_id 
    FROM nibrs_offense) 
LIMIT 100
```

To determine why that was, I reviewed the data and found that `cleared_except_id` had a value for each row where no offense was joined, but lacked a value for each row that did join an offense. Adding '`AND cleared_except_id is NULL`' to the `WHERE` clause further returned nothing, confirming that _every incident without an offense associated to it was "cleared by exceptional means,"_ according to the NIBRS Data Dictionary, signifying that **these incidents are not instances of criminal activity**, making them unessential. Going forward, these incidents that lacked an offense were not included.

**Consistency of Information**:

The CSVs from 2010-2016 had the same columns for each year in each CSV. However, the CSVs from 2017 onward differed in that a `data_year` column was present in each. Some of them lacked columns that were present in earlier CSVs, though nothing essential to this project was missing. For example, the nibrs_incident CSVs from 2017-2019 lacked the columns for `ff_line_number`, `incident_number`, and `ddocname`, all of which are described in the NIBRS Data Dictionary as either _unused_ or _internal metadata_, meaningless to this project's objective. Because of these CSV differences, it was not possible to import them into the existing tables, so I made the decision to import the main CSVs from 2017-2019 to their own unique tables (with the '_alt' suffix) (See [CrimePredView.sql](CrimePredView.sql))

In order to ensure that the `ref_race` demographic table isn't referenced by both the victims and the offenders in the same query for the final view I was creating, I had to make some adjustments via SQL. I added a `race` column to the `nibrs_victim`, `nibrs_victim_addl`, `nibrs_offender`, and `nibrs_offender_addl` tables, with the corresponding information from `ref_race` for each row via a JOIN. I also formatted the `incident_date` column's values to be a consistent DATE format, as they either came in TIMESTAMP format without any HH:MM:SS data or in a mixed date format of 01-JAN-19. My queries can be found in [DB Mods](DBMods.sql).

Upon importing all relevant CSVs, I created [a custom view](CrimePredView.sql) from which I was able to export a dataset to import into Jupyter Notebooks and further explore.