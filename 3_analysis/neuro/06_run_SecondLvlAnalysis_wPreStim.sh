#!/bin/bash -x

#Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/Ashleys_Honors_Thesis
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/3_analysis/neuro/
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/particpants.txt`


# This will run our first level analysis in parallel much as it had above
for subj in ${SUBJECTS}; do

    echo "+++++ Second Level Processing for ${subj} +++++"

        #Manages the number of jobs and cores
        SCRIPTNAME=${CODE}/*_script_SecondLvlAnalysis_wPreStim.sh
        NSUBJ=10
        while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NSUBJ ]; do
            sleep 30s
        done
        bash $SCRIPTNAME $subj &
        sleep 5s

done