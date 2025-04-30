SUBJ=$1

# Environmental Variables
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=../../1_data/deriv/fmriprep
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=../../3_analysis/neuro/

# Creating a folder for each participant to house .fsf's
echo "===> Starting processing of ${SUBJ}"
# chmod -R 777 ${PROJECT}/${SUBJ}/func
mkdir ${PROJECT}/${SUBJ}/func/DesignFiles

# Creating a for-loop to cycle through runs
for RUN in 1 2 ; do

    echo "===> Creating .fsf file for ${SUBJ}, run ${RUN}"

    FILENAME=${PROJECT}/${SUBJ}/func/DesignFiles/design_run${RUN}.fsf
            
    # Copy the design files into the subject directory to be modified
    cp ${CODE}/01_script_design_lvl1.fsf \
       ${FILENAME}

    # Granting sed permission to read files
    # chmod -R 777 ${PROJECT}/${SUBJ}/func/DesignFiles

    # Replacing subject ID in each file
    # We are using the | character to delimit the patterns
    case "$SUBJ" in

	sub-0035 | sub-4590 | sub-6943 | sub-6799 | sub-6977 | sub-8746 | sub-5006 )
		sed -i -e "s|sub-0295|${SUBJ}|g" \
				-e "s|run-1|run-${RUN}|g" \
				-e "s|run1|run${RUN}|g" \
				-e "s|Run-1|Run-${RUN}|g" \
				-e "s|Run1|Run${RUN}|g" \
				-e "s|729|759|g"\
				${FILENAME}

        /usr/local/fsl/bin/feat ${FILENAME} ;;          
    * )
		# sed -i -e "s|sub-0295|${SUBJ}|g" \
		# 		-e "s|run-1|run-${RUN}|g" \
		# 		-e "s|run1|run${RUN}|g" \
		# 		-e "s|Run-1|Run-${RUN}|g" \
		# 		-e "s|Run1|Run${RUN}|g" \
		# 		${FILENAME} ;;
esac

    # Now everything is set up to run feat
    # echo "===> Running FEAT for ${SUBJ}, run ${RUN}"
    # /usr/local/fsl/bin/feat ${FILENAME}   

done