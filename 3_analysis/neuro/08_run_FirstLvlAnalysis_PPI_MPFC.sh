#!/bin/bash -x

#Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final
#DERIV is the output for your preprocessed data
DERIV=${PROJECT}/deriv/pipeline_1/fmriprep
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/Participants.txt`
#NRUNS defines the number of runs in your dataset
NRUNS=5

for pipe in 1 2; do

    #DERIV is the output for your preprocessed data
    DERIV=${PROJECT}/deriv/pipeline_${pipe}/fmriprep

    # This will run our first level analysis in parallel much as it had above
    for subj in ${SUBJECTS}; do

        echo "+++++ PPI Processing for ${subj} +++++"

        for run in `seq -w 1 ${NRUNS}` ; do

            if [ $pipe -eq 1 ]
            then
                #Manages the number of jobs and cores
                SCRIPTNAME=${CODE}/08_script_FirstLvlAnalysis_PPI_MPFC.sh
                NSUBJ=10
                while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NSUBJ ]; do
                    sleep 1m
                done
                bash $SCRIPTNAME $subj $run &
                sleep 5s
            else
                #Manages the number of jobs and cores
                SCRIPTNAME=${CODE}/08_script_FirstLvlAnalysis_AROMA_PPI_MPFC.sh
                NSUBJ=10
                while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NSUBJ ]; do
                    sleep 1m
                done
                bash $SCRIPTNAME $subj $run &
                sleep 5s

            fi
        done
    done
done