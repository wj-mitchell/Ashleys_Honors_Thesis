#!/bin/bash -x

#Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/Participants.txt`
# NRUNS is the number of runs each participant has
NRUNS=5

# Granting permission to copy files
sudo chmod -R 777 ${CODE}

for pipe in 1 2; do

    #DERIV is the output for your preprocessed data
    DERIV=${PROJECT}/deriv/pipeline_${pipe}/fmriprep

    # This will run our first level analysis in parallel much as it had above
    for subj in ${SUBJECTS}; do

        for run in `seq -w 1 ${NRUNS}` ; do

            # The feat directory containing first level process information
            FEAT=${DERIV}/${subj}/func/Task_run-${run}_PPI_MPFC.feat

            echo "===> Creating registration files for ${subj}'s run ${run}"
            sudo chmod -R 777 ${FEAT}
            sudo mkdir ${FEAT}/reg
            sudo chmod -R 777 ${FEAT}/reg

            ln -s $FSLDIR/etc/flirtsch/ident.mat ${FEAT}/reg/example_func2standard.mat
            ln -s $FSLDIR/etc/flirtsch/ident.mat ${FEAT}/reg/standard2example_func.mat
            ln -s ${FEAT}/mean_func.nii.gz ${FEAT}/reg/standard.nii.gz

        done
        if [ $pipe -eq 1 ]
        then
            echo "+++++ Second Level Processing for ${subj} +++++"

                #Manages the number of jobs and cores
                SCRIPTNAME=${CODE}/09_script_SecondLvlAnalysis_MPFC.sh
                NSUBJ=10
                while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NSUBJ ]; do
                    sleep 1m
                done
                bash $SCRIPTNAME $subj &
                sleep 5s
        else
            echo "+++++ Second Level Processing for ${subj} +++++"

                #Manages the number of jobs and cores
                SCRIPTNAME=${CODE}/09_script_SecondLvlAnalysis_AROMA_MPFC.sh
                NSUBJ=10
                while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NSUBJ ]; do
                    sleep 1m
                done
                bash $SCRIPTNAME $subj &
                sleep 5s

        fi
    done
done