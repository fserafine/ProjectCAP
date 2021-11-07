# Crime Prediction with Machine Learning
## Author: Frank Serafine | README

Using publicly-available crime data from the FBI, this project aimed to train several machine learning models to be able to predict crime data for a given year.

The database constructed in SQLite from the FBI's provided CSV files can be downloaded [from this link](https://drive.google.com/file/d/1Q7emKSnD8K-WJrrnZW410LEhxlXoYg63/view?usp=sharing), and is approximately 600 MB zipped / 2.5 GB unzipped.

This dataset has the following:
- 4,710,743 observations
- 3,182,165 individual incidents
- 3,400,357 individual offenses
- 3,716,473 individual offenders
- 3,553,297 individual victims
- 51 offense types

The final pre-processed CSV is narrowed down in the Jupyter Notebook file in this repo to 3,652 single-day aggregates used to train the models. It can be downloaded [from this link](https://drive.google.com/file/d/16pJ4gI36O67LvdLTRKan774GaBXEcsFB/view?usp=sharing), and is approximately 700 MB.

Files that exist in this repo serve to highlight the work that went in to the project and detail the results.