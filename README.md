# Project CAP - Crime Analysis & Prediction
## Author: Frank Serafine | README

Using publicly-available crime data from the FBI, this project aimed to train several machine learning models to be able to predict crime data for a given year in order to establish a predictable "expected" crime level measurement that is responsive to seasonal trends. From this, abnormalities can be classified and contextualized through supporting visualization.

The database constructed in SQLite from the FBI's provided CSV files can be downloaded [from this link](https://drive.google.com/file/d/1Q7emKSnD8K-WJrrnZW410LEhxlXoYg63/view?usp=sharing), and is approximately 630 MB zipped / 2.6 GB unzipped.

In [EDA.md](https://github.com/fserafine/CrimePrediction/blob/main/01.%20EDA.md), I explain the compiling and preparing of the SQLite database and elaborate on my modifications and preprocessing in [DBMods-FtWorth.sql](https://github.com/fserafine/CrimePrediction/blob/main/02.%20DBMods-FtWorth.sql).

In [CrimePred.ipynb](https://github.com/fserafine/CrimePrediction/blob/main/03.%20CrimePred.ipynb), I de-duplicate the data and aggregate to 3,652 single-day crime level counts and sums depending on the feature and walk through the process of modeling, documenting the work each step of the way.

Files that exist in this repo serve to highlight the work that went in to the project and detail the results.