
# PROJECT CAP (Crime Analysis & Prediction)

**Author: Frank Serafine**  
[GitHub](https://github.com/fserafine) | [LinkedIn](https://www.linkedin.com/in/frankserafine/) | [Tableau Public](https://public.tableau.com/app/profile/frank.serafine)

---

## SUMMARY

**GOAL:** Analyze and model time series data to predict crime activity over two years, given eight years of history, in order to establish an "expected" crime level measurement that is responsive to seasonal trends and generalizes well. From this, classify the crime levels of the predicted range as normal or abnormal.

**BUSINESS USE CASE:** Specifically, this is a way for journalists, the media at large, and citizens alike to obtain an informed view of the crime activity around them and interact with information normally taken for granted or assumed on a shallow level.

Generalized, if this analysis is performed on a statewide or nationwide level, it will provide an educated lens through which to view crime in society. The focus for the project is on ___Fort Worth, TX___, but the process could be applied to any city to get local insights.

By providing a well-researched estimate for whether or not a given time period's actual crime levels are abnormal, even law enforcement could use it to strategize opportunities, plan resource allocation, or classify times of relative success. 

**PROJECT DATA SOURCE:** FBI's [Crime Data Explorer](https://crime-data-explorer.fr.cloud.gov/pages/downloads) CSV downloads

**DATA FLOW:** Data Source >> [SQL db](https://drive.google.com/file/d/1Q7emKSnD8K-WJrrnZW410LEhxlXoYg63/view?usp=sharing) >> [Python/Jupyter Notebook](https://github.com/fserafine/ProjectCAP/blob/main/03.%20CrimePred.ipynb)

**SUPPORTING VISUALIZATIONS:** Three Tableau Public dashboards showcasing the project's EDA can be viewed [here](https://public.tableau.com/app/profile/frank.serafine/viz/ProjectCAP-Ft_WorthCrimeStats3Dashboards/CrimeLevelsDemographics-Ft_Worth) and one showcasing the final averaged predictions of three ML time series models can be viewed [here](https://public.tableau.com/app/profile/frank.serafine/viz/ProjectCAP-MLPredictions/MachineLearningPredictionsvsActual)

**OUTCOME:** Classifications were made by using the metric of two standard deviations away from the mean of the machine learning ensemble's predicted crime levels, allowing me to classify 2018-2019 crime levels as __74% abnormal__, with 68% of that being ___abnormally low___ crime.

---

## SIMPLE SETUP 

### Step 1: Clone this repo to your local machine

```bash
git clone https://github.com/fserafine/ProjectCAP.git
```

### Step 2: Create the environment

The Anaconda environment I used can be installed easily after downloading `crime_pred_env.txt` and issuing the following command to Anaconda in a terminal:

```bash
conda create -n crime_pred --file crime_pred_env.txt
```

I used Python 3.8.12 for this project.

It is also recommended to install a kernel for the Jupyter notebook with the following:

```bash
ipython kernel install --name "crime_pred" --user
```
### Step 3: Get the database

The database I constructed in SQLite from the FBI's provided CSV files can be downloaded [from this link](https://drive.google.com/file/d/1Q7emKSnD8K-WJrrnZW410LEhxlXoYg63/view?usp=sharing), and is approximately 630 MB zipped / 2.6 GB unzipped. Unzip it to the same local directory where you've cloned this repository, as it is needed for the Jupyter notebook.

### Step 4: Open the Jupyter notebook

In [03. CrimePred.ipynb](https://github.com/fserafine/ProjectCAP/blob/main/03.%20CrimePred.ipynb), I inspect the data, aggregate it to daily crime level counts and sums (depending on the feature), and walk through the process of modeling, documenting the work each step of the way.

---

### Supplemental Files

Additional files exist in this repo serve to highlight the work that went in to the project and detail the results.

In [01. EDA.md](https://github.com/fserafine/ProjectCAP/blob/main/01.%20EDA.md), I explain the compiling and preparing of the SQLite database and elaborate on my modifications and preprocessing of the imported data in [02. DBMods-FtWorth.sql](https://github.com/fserafine/ProjectCAP/blob/main/02.%20DBMods-FtWorth.sql).

Although I give an option to pickle the models for further use in cells within the Jupyter notebook, a .zip file containing the exported model pickles can be downloaded [here](https://drive.google.com/file/d/1sDOPOZjFILW5OE1am9TLe2-yXcO3G0cF/view?usp=sharing) and is around 84 MB zipped, 162 MB unzipped.

Lastly, also included are several Tableau workbooks with data extracts (.hyper files) that contain my interactive dashboards and worksheets exploring the dataset.