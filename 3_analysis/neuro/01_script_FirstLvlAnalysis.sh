SUBJ=$1

# Environmental Variables
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT="/media/tuo62915/TOSHIBA EXT"
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=/home/tuo62915/Documents/GitHub/Ashleys_Honors_Thesis/3_analysis/neuro/



# Creating a folder for each participant to house .fsf's
echo "===> Starting processing of ${SUBJ}"
sudo chmod -R 777 ${PROJECT}/${SUBJ}/func
sudo mkdir ${PROJECT}/${SUBJ}/func/DesignFiles

# Creating a for-loop to cycle through runs
for RUN in 1 2 ; do

    echo "===> Creating .fsf file for ${SUBJ}, run ${RUN}"
            
    # Copy the design files into the subject directory to be modified
    sudo cp ${CODE}/01_script_design_lvl1.fsf \
            ${PROJECT}/${SUBJ}/func/DesignFiles/design_run${RUN}.fsf

    # Granting sed permission to read files
    sudo chmod -R 777 ${PROJECT}/${SUBJ}/func/DesignFiles

    # Replacing subject ID in each file
    # We are using the | character to delimit the patterns
    case "$SUBJ" in
    * )
        sudo sed -i -e "s|sub-0295|${SUBJ}|g" \
                    -e "s|run-1|run-${RUN}|g" \
                    -e "s|run1|run${RUN}|g" \
                    ${PROJECT}/${SUBJ}/func/DesignFiles/design_run${RUN}.fsf ;;
    esac

    # Now everything is set up to run feat
    echo "===> Running FEAT for ${SUBJ}, run ${RUN}"
    /usr/local/fsl/bin/feat ${PROJECT}/${SUBJ}/func/DesignFiles/design_run${RUN}.fsf   

done
echo