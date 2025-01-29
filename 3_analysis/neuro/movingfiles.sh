#!/bin/bash
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT="/media/tuo62915/TOSHIBA EXT"
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=/home/tuo62915/Documents/GitHub/Ashleys_Honors_Thesis/3_analysis/neuro/
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/particpants.txt`

for subj in ${SUBJECTS}; do
FOLDER_PATH=/home/tuo62915/Documents/GitHub/Ashleys_Honors_Thesis/1_data/deriv/fmriprep/${subj}/func
if [ ! -d "$FOLDER_PATH" ]; then
    echo "Folder does not exist. creating it now..."
    mkdir -p "$FOLDER_PATH"
    fi
    for run in 1 2; do

        cp "${PROJECT}/${subj}/func/${subj}_task-uncertainty_run-${run}_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz" ${FOLDER_PATH}
    done
done