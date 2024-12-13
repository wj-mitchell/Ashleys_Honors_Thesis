subj=$1

#Environmental Variables
#DERIV is the output for your preprocessed data
DERIV=/data/MRI_Final/deriv/pipeline_1/fmriprep
#CODE is where scripts are housed
CODE=/data/MRI_Final/code

echo "===> Creating .fsf file for ${subj}"

# Granting permission to copy files
sudo chmod -R 777 ${DERIV}/${subj}/func/DesignFiles/

# Copy the design files into the subject directory to be modified
cp ${CODE}/09_script_design_lvl2_MPFC.fsf \
   ${DERIV}/${subj}/func/DesignFiles/design_lvl2_MPFC.fsf

# Granting sed permission to read files
sudo chmod -R 777 ${DERIV}/${subj}/func

# Replacing subject ID in each file
# We are using the | character to delimit the patterns 
sed -i -e "s|sub-105|${subj}|g" \
      ${DERIV}/${subj}/func/DesignFiles/design_lvl2_MPFC.fsf

# Now everything is set up to run feat
echo "===> Running FEAT for ${subj}"
/usr/local/fsl/bin/feat ${DERIV}/${subj}/func/DesignFiles/design_lvl2_MPFC.fsf

