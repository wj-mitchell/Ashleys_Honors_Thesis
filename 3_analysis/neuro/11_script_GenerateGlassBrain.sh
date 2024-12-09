seed=$1
pipe=$2
cope=$3
zstat=$4

#Environmental Variables
#DERIV is the output for your preprocessed data
DERIV=/data/MRI_Final/deriv/pipeline_${pipe}/fmriprep
#CODE is where scripts are housed
CODE=/data/MRI_Final/code

echo "===> Creating .fsf file for Pipeline ${pipe}"
      
# Copy the design files into the subject directory to be modified
sudo cp ${CODE}/11_script_GenerateGlassBrain.py \
        ${DERIV}/DesignFiles/GenerateGlassBrain_${seed}_Cope${cope}_Zstat${zstat}.py

# Granting sed permission to read files
sudo chmod -R 777 ${DERIV}/DesignFiles
if [ "$seed" == "DMN" ]
then 
        # Replacing subject ID in each file
        # We are using the | character to delimit the patterns 
        sed -i -e "s|pipeline_1|pipeline_${pipe}|g" \
        -e "s|_DMN|_${seed}|g" \
        -e "s|cope1.g|cope${cope}.g|g" \
        -e "s|cope1_|cope${cope}_|g" \
        -e "s|zstat1|zstat${zstat}|g" \
        ${DERIV}/DesignFiles/GenerateGlassBrain_${seed}_Cope${cope}_Zstat${zstat}.py

else
        sed -i -e "s|pipeline_1|pipeline_${pipe}|g" \
        -e "s|_DMN|_${seed}|g" \
        -e "s|cope1.g|cope${cope}.g|g" \
        -e "s|cope1_|cope${cope}_|g" \
        -e "s|zstat1|zstat${zstat}|g" \
        -e "s|-54, 26|48, -10|g" \
        ${DERIV}/DesignFiles/GenerateGlassBrain_${seed}_Cope${cope}_Zstat${zstat}.py
fi

# # Now everything is set up to run feat
echo "===> Running Python for Pipe ${pipe}"
python ${DERIV}/DesignFiles/GenerateGlassBrain_${seed}_Cope${cope}_Zstat${zstat}.py