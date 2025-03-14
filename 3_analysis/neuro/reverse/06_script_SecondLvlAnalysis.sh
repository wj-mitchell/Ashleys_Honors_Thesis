subj=$1

#Environmental Variables

# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/Ashleys_Honors_Thesis
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=${PROJECT}/3_analysis/neuro/
#DERIV is the output for your preprocessed data
DERIV=${PROJECT}/1_data/deriv/fmriprep

echo "===> Creating .fsf file for ${subj}"

# Copy the design files into the subject directory to be modified
cp ${CODE}/reverse/*_script_design_lvl2.fsf \
   ${DERIV}/${subj}/func/DesignFiles/design_lvl2_reverse.fsf

# Replacing subject ID in each file
# We are using the | character to delimit the patterns 
sed -i -e "s|sub-0295|${subj}|g" \
      ${DERIV}/${subj}/func/DesignFiles/design_lvl2_reverse.fsf

# Now everything is set up to run feat
echo "===> Running FEAT for ${subj}"
/usr/local/fsl/bin/feat ${DERIV}/${subj}/func/DesignFiles/design_lvl2_reverse.fsf

