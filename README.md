# Project CAP - Crime Analysis & Prediction
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

The pre-processed CSV (with suffix '-orig') used at the beginning of the Jupyter Notebook file in this repo, **which does contain duplicates**, is available [from this link](https://drive.google.com/file/d/1awZfcBDqouJptRimN4-yUteU-lULxsIF/view?usp=sharing) and is ~90 MB zipped / 953 MB unzipped.

A CSV was exported after de-duping the dataset and is available [from this link](https://drive.google.com/file/d/1yfvc_L3t1TIePMb0jszKbHlQvGdcBFPa/view?usp=sharing) and is ~100 MB zipped / 770 MB unzipped.

In the notebook, I further aggregated the data to 3,652 single-day counts and sums depending on the feature. Before the non-numeric features were binarized to make the data ml-friendly, I exported the single-day aggregates to a CSV that can be downloaded [from this link](https://drive.google.com/file/d/1-IbYmCnRixvVafif1hESV72cXBQ7lm1u/view?usp=sharing) for the sake of making clean data for visualizations in Tableau. It is about 1.3 MB zipped / 6 MB unzipped.

Files that exist in this repo serve to highlight the work that went in to the project and detail the results.