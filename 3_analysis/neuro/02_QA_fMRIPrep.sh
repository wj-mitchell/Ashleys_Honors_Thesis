#!/bin/bash

# Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final/
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code/
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
DERIV=${PROJECT}/deriv/pipeline_1/fmriprep/
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/Participants.txt`

# iterate through each of our subjects
for i in ${SUBJECTS}; do

	# Specifying the number of runs based on each participant
	case "$i" in
		# All of our participants have all five runs, so this is a little bit of overkill, but allows us to easily pivot in the future if that should change.
	    * )
	        NRUNS=5 ;;
	esac

	# Iterate through each of the subjects' runs
	for j in `seq -w 1 ${NRUNS}` ; do

		# Dearch for whether this file exists and if it doesn't ...
		if [ ! -f "${DERIV}/${i}/func/${i}_task-trust_run-${j}_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz" ]; then

			# Record that participant's ID and the run number that is missing in a text file.
			echo "${i}; Run ${j}" >> ${CODE}/02_QAresults_fMRIPrep.txt

		fi

	done

done