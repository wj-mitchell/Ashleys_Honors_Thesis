subj=$1
roi=$2
run=$3

#Environmental Variables
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/home/tuo62915/Documents/GitHub/Ashleys_Honors_Thesis/1_data/deriv/fmriprep
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=/home/tuo62915/Documents/GitHub/Ashleys_Honors_Thesis/3_analysis/neuro/
#kj- add path ROI for rois 
ROI=${CODE}/rois
# The feat directory containing first level process information
FEAT=${PROJECT}/${subj}/func/Task_run-${run}.feat     

echo "===> Transforming ${subj}'s run ${run} ${roi} to native space"
flirt -in ${ROI}/${roi}_bin.nii.gz \
      -ref ${PROJECT}/${subj}/func/Task_run-${run}.feat/example_func.nii.gz \
      -out ${FEAT}/rois/${subj}_${roi}_func \
      -applyxfm -init ${FEAT}/reg/example_func2standard.mat \
      -datatype float


fslmaths ${FEAT}/rois/${subj}_${roi}_func.nii.gz \
		 -thr 0.5 -bin ${FEAT}/rois/${subj}_${roi}_func_bin.nii.gz

echo "===> Extracting timeseries of ${subj}'s run ${run} ${roi}" 
fslmeants -i ${PROJECT}/${subj}/func/${subj}_task-trust_run-${run}_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz \
	    -o ${PROJECT}/${subj}/func/${subj}_task-trust_run-${run}_roi-${roi}_timecourse.txt \
	    -m ${FEAT}/rois/${subj}_${roi}_func_bin.nii.gz