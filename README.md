# The Role of Anxiety in mPFC-Amygdala Connectivity During Naturalistic Viewing

## Project Goals: 

## Project Timeline & Tasks:

We're going to start by building the repository in which to house the data for the analysis, moving the data to this repository, and then eventually conducting the analysis. Much of this can be done manually with painstaking repetition, but could also be automated with a little bit of coding. Below I (Billy) am outlining the general steps that I think we need to complete. I will try to break them to their smallest components when I can. I will add a carrot behind stages that I think we will have to do together, but all other things, I think you could try on your own. 

### Orientation and Literature Review
- Familiarize with the literature on:
  - mPFC-amygdala connectivity.
  - The role of anxiety in functional brain connectivity.
- Read tutorials and documentation on:
  - [Introduction to Coding]()
  - [FSL basics](https://www.youtube.com/watch?v=9ionYVXUQn8)
  - [PPI analysis theory](https://youtu.be/L3iBhfEYEgE?si=kx8obIQU-3VKGo-E)[[Part 2] (https://www.youtube.com/watch?v=M8APlF6oBgA)].
  - [ROI Creation in FSL](https://www.youtube.com/watch?v=N9hE0vAztnQ).
  - [FSL Level 1 FEAT](https://www.youtube.com/watch?v=aB-bmcp5ET4).
  - [Using pre-processed data from fMRIPrep in FSL](https://youtu.be/U3tG7JMEf7M?si=nPBjYclPS3lrrOnz).
  - [FSL Level 2 FEAT](https://youtu.be/ZrkgRMpaFpI?si=jzNvaX2RN0yN-nhm).
  - [FSL Level 3 FEAT](https://youtu.be/nyajZKJ-uwk?si=g4g-fPEHWGEv4v-G).

### Data Preparation
- Organize fMRIPrep outputs for each subject.
  - In the `01_data/neuro` folder, create a new directory called `deriv` and within a folder called `fmriprep`.
  - Within `fmriprep`, create a separate folder for each subject (i.e., ..., sub-9997, sub-9998, sub-9999)
  - Within each subject folder, create new folders called `func` and `onset`
  - Copy functional image .nii.gz files from individual subject folders in the Uncertainty directory to individual subject folders in this project ^
  - Copy confound files from individual subject folders in the Uncertainty directory to individual subject folders in this project ^
  - Create onset files for each individual subject for the duration of the video using R and store them in each subject's `onset` folder ^
- Create or find the masks for the mPFC and Amyg
- Preprocess the fMRI time series for PPI analysis:
  - Extract the seed region time series (mPFC) using FSL’s `fslmeants`.
  - Verify anatomical accuracy of seed region placement using a brain atlas.

### PPI Setup and Execution
- Set up a generalized PPI (gPPI) model in FSL, including interaction terms.
- Run the first-level PPI analysis for each subject.
- Check for errors or anomalies in PPI outputs.

### Group-Level Analysis
- Aggregate PPI outputs across subjects for group-level analysis.
- Integrate anxiety scores (STAI summary statistics) as a covariate.
- Set up a moderation model in FSL to test the interaction between anxiety and mPFC-amygdala connectivity.
- Run group-level statistics in FSL.
- Visualize connectivity maps and statistical results.

### Interpretation of Results
- Interpret the group-level connectivity findings:
  - Identify significant clusters in the mPFC and amygdala.
  - Assess the moderating role of anxiety.
- Cross-check findings with the literature.

### Visualization and Reporting
- Create visualizations:
  - Connectivity maps.
  - Scatterplots showing the relationship between anxiety and connectivity strength.
- Summarize findings in clear, concise language.
- Draft results and discussion sections for the final report.

## Primary Results:

## Relevant Links:
 
