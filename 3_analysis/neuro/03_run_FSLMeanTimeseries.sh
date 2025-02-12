#!/bin/bash -x

# Environmental Variables
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/Ashleys_Honors_Thesis/1_data/deriv/fmriprep
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=/data/Ashleys_Honors_Thesis/3_analysis/neuro
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/particpants.txt`
# Contains a list of your subjects, which should match the names of your BIDS folders
MASKS=`cat ${CODE}/rois/masks.txt`

for roi in ${MASKS} ; do

    echo "+++++ Binarizing Mask at ${CODE}/rois/${roi}.nii.gz +++++"

    fslmaths ${CODE}/rois/${roi}.nii.gz -bin ${CODE}/rois/${roi}_bin.nii.gz

done 

# This will run our first level analysis in parallel much as it had above
for subj in ${SUBJECTS}; do

    for run in 1 2 ; do

        # The feat directory containing first level process information
        FEAT=${PROJECT}/${subj}/func/Task_run-${run}.feat

        echo "===> Creating registration files for ${subj}'s run ${run}"
        mkdir ${FEAT}/reg
        sudo chmod -R 777 ${FEAT}/reg
        mkdir ${FEAT}/rois
        sudo chmod -R 777 ${FEAT}/rois

        ln -s $FSLDIR/etc/flirtsch/ident.mat ${FEAT}/reg/example_func2standard.mat
        ln -s $FSLDIR/etc/flirtsch/ident.mat ${FEAT}/reg/standard2example_func.mat
        ln -s ${FEAT}/mean_func.nii.gz ${FEAT}/reg/standard.nii.gz

        for roi in ${MASKS} ; do
    
            echo "+++++ Extracting Time Series for ${subj}'s Run ${run} in ${roi} +++++"

            #Manages the number of jobs and cores
            SCRIPTNAME=${CODE}/03_script_FSLMeanTimeseries.sh
            NSUBJ=10
            while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NSUBJ ]; do
                sleep 1m
            done
            bash $SCRIPTNAME $subj $roi $run &
            sleep 5s

        done
    done
done