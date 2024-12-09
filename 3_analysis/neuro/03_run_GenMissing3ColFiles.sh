#!/bin/bash -x

#Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final/
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code/
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/Participants.txt`
#NRUNS defines the number of runs in your dataset
NRUNS=5

for pipe in `seq -w 1 2` ; do

#DERIV is the output for your preprocessed data
DERIV=${PROJECT}/deriv/pipeline_${pipe}/fmriprep

    for subj in ${SUBJECTS}; do

        # Specifying the number of runs based on each participant
        case "$subj" in
            * )
                NRUNS=5 ;;
        esac

        for run in `seq -w 1 ${NRUNS}` ; do

            if [ ! -f "${DERIV}/${subj}/func/3col_onsets/run-0${run}_missed_trial.txt" ]; then

                echo "" >> ${DERIV}/${subj}/func/3col_onsets/run-0${run}_missed_trial.txt

            fi

        done

    done

done