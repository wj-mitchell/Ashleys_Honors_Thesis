subj=$1
run=$2

# Environmental Variables
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/MRI_Final
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/code
# RAW should contain our data that has been cleaned or organized (BIDS) but not modified. 
RAW=${PROJECT}/raw
# DERIV should contain the data that has been preprocessed or modified in some way. It's what we'll usually use to analyze
DERIV=${PROJECT}/deriv/pipeline_1/fmriprep

    echo "===> Creating .fsf file for ${subj}, run ${run}"
            
    # Copy the design files into the subject directory to be modified
    sudo cp ${CODE}/08_script_design_lvl1_PPI_MPFC.fsf \
            ${DERIV}/${subj}/func/DesignFiles/design_run${run}_PPI_MPFC.fsf

    # Granting sed permission to read files
    sudo chmod -R 777 ${DERIV}/${subj}/func/DesignFiles

    # Replacing subject ID in each file
    # We are using the | character to delimit the patterns
    case "${subj}" in
    * )
        sudo sed -i -e "s|sub-105|${subj}|g" \
                    -e "s|run-01|run-0${run}|g" \
                    -e "s|run-1|run-${run}|g" \
                    -e "s|run01|run0${run}|g" \
                    -e "s|run1|run${run}|g" \
                    ${DERIV}/${subj}/func/DesignFiles/design_run${run}_PPI_MPFC.fsf ;;
    esac

    # Now everything is set up to run feat
    echo "===> Running FEAT for ${subj}, run ${run}"
    /usr/local/fsl/bin/feat ${DERIV}/${subj}/func/DesignFiles/design_run${run}_PPI_MPFC.fsf   
