seed=$1
pipe=$2
cope=$3

#Environmental Variables
#DERIV is the output for your preprocessed data
DERIV=/data/MRI_Final/deriv/pipeline_${pipe}/fmriprep
#CODE is where scripts are housed
CODE=/data/MRI_Final/code

echo "===> Creating .fsf file for Pipeline ${pipe}"
      
# Copy the design files into the subject directory to be modified
sudo cp ${CODE}/10_script_design_lvl3.fsf \
        ${DERIV}/DesignFiles/design_lvl3_${seed}_Cope${cope}.fsf

# Granting sed permission to read files
sudo chmod -R 777 ${DERIV}/DesignFiles

# Replacing subject ID in each file
# We are using the | character to delimit the patterns 
sed -i -e "s|pipeline_1|pipeline_${pipe}|g" \
       -e "s|_DMN|_${seed}|g" \
       -e "s|cope1|cope${cope}|g" \
       -e "s|cope${cope}.nii.gz|cope1.nii.gz|g" \
      ${DERIV}/DesignFiles/design_lvl3_${seed}_Cope${cope}.fsf

# # Now everything is set up to run feat
echo "===> Running FEAT for Pipe ${pipe}"
/usr/local/fsl/bin/feat ${DERIV}/DesignFiles/design_lvl3_${seed}_Cope${cope}.fsf