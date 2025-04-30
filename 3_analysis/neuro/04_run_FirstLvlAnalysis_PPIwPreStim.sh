#!/bin/bash -x

#Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/Ashleys_Honors_Thesis/1_data/deriv/fmriprep
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=/data/Ashleys_Honors_Thesis/3_analysis/neuro/
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/particpants.txt`

# This will run our first level analysis in parallel much as it had above
for subj in ${SUBJECTS}; do

    echo "+++++ PPI Processing for ${subj} +++++"

    for run in 1 2 ; do

        #Manages the number of jobs and cores
        SCRIPTNAME=${CODE}/*_script_FirstLvlAnalysis_PPIwPreStim.sh
        NSUBJ=20
        while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NSUBJ ]; do
            sleep 30s
        done
        bash $SCRIPTNAME $subj $run &
        sleep 3s

    done
done