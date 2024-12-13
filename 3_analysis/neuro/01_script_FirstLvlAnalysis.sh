SUBJ=$1

# Environmental Variables
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code/
# RAW should contain our data that has been cleaned or organized (BIDS) but not modified. 
RAW=${PROJECT}/raw/
# DERIV should contain the data that has been preprocessed or modified in some way. It's what we'll usually use to analyze
DERIV=${PROJECT}/deriv/pipeline_1/fmriprep


# Creating a folder for each participant to house .fsf's
echo "===> Starting processing of ${SUBJ}"
sudo chmod -R 777 ${DERIV}/${SUBJ}/func
sudo mkdir ${DERIV}/${SUBJ}/func/DesignFiles

# Specifying the number of runs based on each participant
case "$SUBJ" in
    * )
        NRUNS=5 ;;
esac

# Creating a for-loop to cycle through runs
for RUN in `seq -w 1 ${NRUNS}` ; do

    echo "===> Creating .fsf file for ${SUBJECT}, run ${RUN}"
            
    # Copy the design files into the subject directory to be modified
    sudo cp ${CODE}/05_script_design_lvl1.fsf \
            ${DERIV}/${SUBJ}/func/DesignFiles/design_run${RUN}.fsf

    # Granting sed permission to read files
    sudo chmod -R 777 ${DERIV}/${SUBJ}/func/DesignFiles

    # Replacing subject ID in each file
    # We are using the | character to delimit the patterns
    case "$SUBJ" in
    * )
        sudo sed -i -e "s|sub-105|${SUBJ}|g" \
                    -e "s|run-1|run-${RUN}|g" \
                    -e "s|run1|run${RUN}|g" \
                    ${DERIV}/${SUBJ}/func/DesignFiles/design_run${RUN}.fsf ;;
    esac

    # Now everything is set up to run feat
    echo "===> Running FEAT for ${SUBJ}, run ${RUN}"
    /usr/local/fsl/bin/feat ${DERIV}/${SUBJ}/func/DesignFiles/design_run${RUN}.fsf   

done
echo