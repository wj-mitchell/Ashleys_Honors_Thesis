#!/bin/bash -x

#Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code

for pipe in 1 2; do
    
    #DERIV is the output for your preprocessed data
    DERIV=/data/MRI_Final/deriv/pipeline_${pipe}/fmriprep
    sudo mkdir ${DERIV}/DesignFiles

    for seed in DMN MPFC; do

        for cope in `seq -w 1 9` `seq -w 10 19`; do

            echo "+++++ Third Level Processing for Pipe $pipe, $seed, Cope $cope +++++"

            #Manages the number of jobs and cores
            SCRIPTNAME=${CODE}/10_script_ThirdLvlAnalysis.sh
            NSUBJ=10
            while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NSUBJ ]; do
                sleep 1m
            done
            bash $SCRIPTNAME $seed $pipe $cope &
            sleep 5s

        done
    done
done