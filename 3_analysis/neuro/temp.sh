#!/bin/bash -x

#Environmental Variables
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/Ashleys_Honors_Thesis/1_data/deriv/fmriprep
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=/data/Ashleys_Honors_Thesis/3_analysis/neuro
# Contains a list of your subjects, which should match the names of your BIDS folders
MASKS=`cat ${CODE}/rois/masks.txt`
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/particpants.txt`

# This will run our first level analysis in parallel much as it had above
for subj in ${SUBJECTS}; do

    for run in 1 2 ; do

        for roi in ${MASKS} ; do
    
            mv ${PROJECT}/${subj}/func/${subj}_task-uncertainty_run-${run}_roi-roi_${roi}_timecourse.txt \
               ${PROJECT}/${subj}/func/${subj}_task-uncertainty_run-${run}_roi-${roi}_timecourse.txt 
        done
    done
done