#!/bin/bash

#Environmental Variables
# NRUNS defines the number of runs in your dataset
NRUNS=5
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final/
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code/
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/Participants.txt`

# Go back to root directory
cd

# Iterate through all of our subjects
for i in ${SUBJECTS}; do

	# Iterate through each of the subjects 5 runs
	for j in `seq -w 1 ${NRUNS}` ; do

		# If this file does not exist
		if [ ! -f "${PROJECT}/raw/${i}/func/${i}_task-trust_run-0${j}_bold.nii.gz" ]; then

			# Then record that file's PID and run information in a text file
			echo "${i}; Run ${j}" >> ${CODE}/00_QAresults_FunctionalScans.txt

		fi

	done

done