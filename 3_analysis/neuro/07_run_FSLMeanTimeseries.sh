#!/bin/bash -x

#Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final/
#DERIV is the output for your preprocessed data
DERIV=${PROJECT}/deriv/pipeline_1/fmriprep
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code/
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/Participants.txt`
#NRUNS defines the number of runs in your dataset
NRUNS=5
# Contains a list of your subjects, which should match the names of your BIDS folders
MASKS=`cat ${CODE}/Masks.txt`
#kj- add path ROI for rois 
ROI=${CODE}/rois

sudo chmod -R 777 ${ROI}

for roi in MASKS ; do

    fslmaths ${ROI}/${roi}.nii.gz -bin ${ROI}/${roi}_bin.nii.gz

done 

# This will run our first level analysis in parallel much as it had above
for subj in ${SUBJECTS}; do

    echo "+++++ Second Level Processing for ${subj} +++++"

    for run in `seq -w 1 ${NRUNS}` ; do

        # The feat directory containing first level process information
        FEAT=${DERIV}/${subj}/func/Task_run-${run}.feat

        echo "===> Creating registration files for ${subj}'s run ${run}"
        mkdir ${FEAT}/reg
        sudo chmod -R 777 ${FEAT}/reg
        mkdir ${FEAT}/rois
        sudo chmod -R 777 ${FEAT}/rois

        ln -s $FSLDIR/etc/flirtsch/ident.mat ${FEAT}/reg/example_func2standard.mat
        ln -s $FSLDIR/etc/flirtsch/ident.mat ${FEAT}/reg/standard2example_func.mat
        ln -s ${FEAT}/mean_func.nii.gz ${FEAT}/reg/standard.nii.gz

        for roi in ${MASKS} ; do
    
            #Manages the number of jobs and cores
            SCRIPTNAME=${CODE}/07_script_FSLMeanTimeseries.sh
            NSUBJ=10
            while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NSUBJ ]; do
                sleep 1m
            done
            bash $SCRIPTNAME $subj $roi $run &
            sleep 5s

        done
    done
done