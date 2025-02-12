SUBJ=$1
RUN=$2

# Environmental Variables
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/Ashleys_Honors_Thesis/1_data/deriv/fmriprep
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=/data/Ashleys_Honors_Thesis/3_analysis/neuro/
# Contains a list of your subjects, which should match the names of your BIDS folders
SUBJECTS=`cat ${CODE}/particpants.txt`

    echo "===> Creating .fsf file for ${SUBJ}, run ${RUN}"
            
    FILENAME=${PROJECT}/${SUBJ}/func/DesignFiles/design_run${RUN}_PPI.fsf

    # Copy the design files into the subject directory to be modified
    cp ${CODE}/*_script_design_lvl1_PPI.fsf \
       ${FILENAME}
 
    # Replacing subject ID in each file
    # We are using the | character to delimit the patterns
    case "${SUBJ}" in
 
	0035 | 4590 | 6943 | 6799 | 6977 | 8746 | 5006 )
		sed -i -e "s|sub-0295|${SUBJ}|g" \
				-e "s|run-1|run-${RUN}|g" \
				-e "s|run1|run${RUN}|g" \
				-e "s|Run-1|Run-${RUN}|g" \
				-e "s|Run1|Run${RUN}|g" \
				-e "s|729|759|g"\
				${FILENAME} ;;
    * )
		sed -i -e "s|sub-0295|${SUBJ}|g" \
				-e "s|run-1|run-${RUN}|g" \
				-e "s|run1|run${RUN}|g" \
				-e "s|Run-1|Run-${RUN}|g" \
				-e "s|Run1|Run${RUN}|g" \
				${FILENAME} ;;
    esac

    # Now everything is set up to run feat
    echo "===> Running FEAT for ${SUBJ}, run ${RUN}"
    /usr/local/fsl/bin/feat ${FILENAME} 
