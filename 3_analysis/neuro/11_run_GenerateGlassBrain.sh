#!/bin/bash -x

#Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code

for pipe in 1 2 ; do

    for seed in DMN MPFC ; do

        for cope in `seq -w 1 9` `seq -w 10 19` ; do

            for zstat in `seq -w 1 4` ; do

                echo "+++++ Generating Images for $pipe, $seed, Cope $cope, Zstat $zstat +++++"

                #Manages the number of jobs and cores
                SCRIPTNAME=${CODE}/11_script_GenerateGlassBrain.sh
                NSUBJ=10
                while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NSUBJ ]; do
                    sleep 1m
                done
                bash $SCRIPTNAME $seed $pipe $cope $zstat &
                sleep 5s
            
            done
        done
    done
done