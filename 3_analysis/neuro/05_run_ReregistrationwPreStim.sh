#!/bin/bash -x

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/Ashleys_Honors_Thesis

# SCRIPTS should contain the analysis scripts for this project
SCRIPTS=${PROJECT}/3_analysis/neuro

# DERIV  should contain our data that has been processed through fMRIPrep. 
DERIV=${PROJECT}/1_data/deriv/fmriprep

# Use this .txt file to find Subject IDs
SUBJECTS=`cat ${SCRIPTS}/particpants.txt`

# For every subject that we analyzed at the first level ...
for SUBJ in ${SUBJECTS}; do

    # ... and for every run for every subject ...
    for RUN in 1 2; do
        
        # print this statement ...
        echo "+ Fixing Registration For ${SUBJ}'s Run ${RUN} ActiveVPassive Data+" 
        
        # denote the path to their feat directory
        FEATPATH=${DERIV}/${SUBJ}/func/Task_run-${RUN}.feat

        # Copy the directory over
        cp -r $FEATPATH/reg ${DERIV}/${SUBJ}/func/Task_run-${RUN}_PPIwPreStim.feat
    done
done