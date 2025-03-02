subj=$1
roi=$2
run=$3

#Environmental Variables
# PROJECT captures the filepath for all relevant project data, scripts, documents, etc.
PROJECT=/data/Ashleys_Honors_Thesis/1_data/deriv/fmriprep
# CODE should contain this file, your heuristic.py file (eventually), and your text file containing your list of participants.
CODE=/data/Ashleys_Honors_Thesis/3_analysis/neuro
#kj- add path ROI for rois 
ROI=${CODE}/rois
# The feat directory containing first level process information
FEAT=${PROJECT}/${subj}/func/Task_run-${run}.feat     

echo "===> Extracting timeseries of ${subj}'s run ${run} ${roi}" 
fslmeants -i ${PROJECT}/${subj}/func/${subj}_task-uncertainty_run-${run}_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz \
	      -o ${PROJECT}/${subj}/func/${subj}_task-uncertainty_run-${run}_roi-${roi}_timecourse.txt \
	      -m ${CODE}/rois/roi_${roi}_bin_3mm.nii.gz