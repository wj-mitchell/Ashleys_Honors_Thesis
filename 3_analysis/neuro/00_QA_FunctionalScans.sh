#!/bin/bash

# Run this to check whether any of your functional scans are missing
#Environmental Variables
# NRUNS defines the number of runs in your dataset
NRUNS=2
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT="/media/tuo62915/TOSHIBA EXT"
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=/home/tuo62915/Documents/GitHub/Ashleys_Honors_Thesis/3_analysis/neuro/
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/particpants.txt`

# Go back to root directory
cd

# Iterate through all of our subjects
for i in ${SUBJECTS}; do

	# Iterate through each of the subjects 5 runs
	for j in `seq -w 1 ${NRUNS}` ; do

		#If this file does not exist
		if [ ! -f "${PROJECT}/${i}/func/${i}_task-uncertainty_run-${j}_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz" ]; then

			# Then record that file's PID and run information in a text file
			echo "${i}; Run ${j}" >> ${CODE}/00_QAresults_FunctionalScans.txt

		fi

	done

done