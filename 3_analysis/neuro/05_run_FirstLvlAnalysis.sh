#!/bin/bash -x

#Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final/
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code/
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/Participants.txt`

# This will run our first level analysis in parallel much as it had above
for SUBJ in ${SUBJECTS}; do
    echo "+++++ First Level Processing ${SUBJ} +++++"
    
#Manages the number of jobs and cores
        SCRIPTNAME=${CODE}/05_script_FirstLvlAnalysis.sh
        NSUBJ=10
        while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NSUBJ ]; do
            sleep 1m
        done
        bash $SCRIPTNAME $SUBJ &
        sleep 5s
done