# Read subject lists from the files
SUBJECTS_A=$(cat /data/Ashleys_Honors_Thesis/3_analysis/neuro/CondA_Subs.text)
SUBJECTS_B=$(cat /data/Ashleys_Honors_Thesis/3_analysis/neuro/CondB_Subs.text)

# This will run our first-level analysis in parallel, much like it had above
for subj in $SUBJECTS_A $SUBJECTS_B; do

    cp /data/Social_Regulation/3_data/neuro/deriv/pipeline_1/fmriprep/${subj}/func/${subj}_task-uncertainty_run-*_desc-confounds_timeseries_reduced.tsv /data/Ashleys_Honors_Thesis/1_data/deriv/fmriprep/${subj}/func/

    cp /data/Social_Regulation/3_data/neuro/deriv/pipeline_1/fmriprep/${subj}/func/${subj}_task-uncertainty_run-*_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz /data/Ashleys_Honors_Thesis/1_data/deriv/fmriprep/${subj}/func/

done
