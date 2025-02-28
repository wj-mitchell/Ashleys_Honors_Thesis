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
  - Within each subject folder, create new folders called `func` and `onset`.
  - Add a blank `.gitkeep` file in each folder.
  - Push these changes to github. 
  - Copy functional image .nii.gz files from individual subject folders in the Uncertainty directory to individual subject folders in this project ^
  - Copy confound files from individual subject folders in the Uncertainty directory to individual subject folders in this project ^
  - Create onset files for each individual subject for the duration of the video using R and store them in each subject's `onset` folder ^
- Check the masks for the mPFC and Amyg
  - Verify anatomical accuracy of seed region placement using a brain atlas.
- Preprocess the fMRI time series for PPI analysis:
  - Run an initial whole brain first level analysis (i.e., 01 scripts)
  - Check first level output (i.e., 02 script)
  - Extract the seed region time series (mPFC) using FSL’s `fslmeants`. (i.e., 03 scripts)

### PPI Setup and Execution
- Set up a generalized PPI (gPPI) model in FSL, including interaction terms. (i.e., 04_script_design_lvl1_PPI.fsf)
- Run the first-level PPI analysis for each subject. (i.e., 04 scripts)
- Check for errors or anomalies in PPI outputs.

### Group-Level Analysis
- Aggregate PPI outputs across subjects for group-level analysis. (i.e., 05 scripts)
- Set up a moderation model in FSL to test the interaction between anxiety and mPFC-amygdala connectivity. (i.e., 06_script_design_lvl3.fsf)
- Run group-level statistics in FSL. (i.e., 06 scripts)
- Visualize connectivity maps and statistical results.

### Interpretation of Results
- Interpret the group-level connectivity findings:
  - Identify significant clusters in the mPFC and amygdala.
  - Assess the moderating role of anxiety.
- Cross-check findings with the literature.

## Primary Results:

## Relevant Links:
 
