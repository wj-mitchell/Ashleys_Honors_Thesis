#!/bin/bash -x

# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS_A=`cat 3_analysis/neuro/CondA_Subs.text`
SUBJECTS_B=`cat 3_analysis/neuro/CondB_Subs.text`

# This will run our first level analysis in parallel much as it had above
for subj in ${SUBJECTS_A}; do
    mkdir 1_data/deriv/fmriprep/$subj
        #mkdir 1_data/deriv/fmriprep/$subj/func
        #mkdir 1_data/deriv/fmriprep/$subj/onset
    for onfunc in func onset; do 
        mkdir 1_data/deriv/fmriprep/$subj/$onfunc
            touch 1_data/deriv/fmriprep/$subj/$onfunc/.gitkeep
    done 
done