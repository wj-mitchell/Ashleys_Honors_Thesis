subj=$1
roi=$2
run=$3

#Environmental Variables
#DERIV is the output for your preprocessed data
DERIV=/data/MRI_Final/deriv/pipeline_1/fmriprep
#CODE is where scripts are housed
CODE=/data/MRI_Final/code
#kj- add path ROI for rois 
ROI=${CODE}/rois
# The feat directory containing first level process information
FEAT=${DERIV}/${subj}/func/Task_run-${run}.feat     

echo "===> Transforming ${subj}'s run ${run} ${roi} to native space"
flirt -in ${ROI}/${roi}_bin.nii.gz \
      -ref ${DERIV}/${subj}/func/Task_run-${run}.feat/example_func.nii.gz \
      -out ${FEAT}/rois/${subj}_${roi}_func \
      -applyxfm -init ${FEAT}/reg/example_func2standard.mat \
      -datatype float


fslmaths ${FEAT}/rois/${subj}_${roi}_func.nii.gz \
		 -thr 0.5 -bin ${FEAT}/rois/${subj}_${roi}_func_bin.nii.gz

echo "===> Extracting timeseries of ${subj}'s run ${run} ${roi}" 
fslmeants -i ${DERIV}/${subj}/func/${subj}_task-trust_run-${run}_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz \
	    -o ${DERIV}/${subj}/func/${subj}_task-trust_run-${run}_roi-${roi}_timecourse.txt \
	    -m ${FEAT}/rois/${subj}_${roi}_func_bin.nii.gz