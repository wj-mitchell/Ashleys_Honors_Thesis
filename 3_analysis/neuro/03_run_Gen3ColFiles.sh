#!/usr/bin/env bash

# this script will convert your BIDS *events.tsv files into the 3-col format for FSL
# it relies on Tom Nichols' converter, which we store locally under /data/tools 
# https://github.com/bids-standard/bidsutils

#Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final/
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code/
# RAW should contain our data that has been cleaned or organized (BIDS) but not modified. 
RAW=${PROJECT}/raw/
# DERIV should contain the data that has been preprocessed or modified in some way. It's what we'll usually use to analyze
DERIV=${PROJECT}/deriv/pipeline_1/fmriprep
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/Participants.txt`

# Iterate through each of the participants on our list
for SUBJ in ${SUBJECTS}; do

  # Specifying how many runs each participant has
  # A little bit overkill since all of our participants have 5 runs,
  # but allowing for the possibility to correct in the future
  case "$SUBJ" in
      * )
        NRUNS=5 ;;
  esac

  # Iterate through each of the participants' runs
  for run in `seq -w 1 ${NRUNS}`; do

    # Defining the file we feed into the script
    input=${RAW}/${SUBJ}/func/${SUBJ}_task-trust_run-0${run}_events.tsv

    # Defining where the output should be stored
    output=${DERIV}/${SUBJ}/func/3col_onsets

    # Create the output director, and create its parent directories as needed (-p)
    mkdir -p $output

    # If the file exists, run the script
    if [ -e $input ]; then
      bash /data/tools/bidsutils/BIDSto3col.sh $input ${output}/run-0${run}
    
    # If it doesn't, output an error
    else
      echo "PATH ERROR: cannot locate ${input}."
      exit
    fi

  done
  
done