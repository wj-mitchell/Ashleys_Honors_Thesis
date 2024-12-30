# Read subject lists from the files
SUBJECTS_A=$(cat 3_analysis/neuro/CondA_Subs.text)
SUBJECTS_B=$(cat 3_analysis/neuro/CondB_Subs.text)

# This will run our first-level analysis in parallel, much like it had above
for subj in $SUBJECTS_A; do
    # Create the main subject directory, ensure parent directories are created as needed
    mkdir -p 1_data/deriv/fmriprep/$subj
    
    # Create the func and onset subdirectories with .gitkeep files
    for onfunc in func onset; do 
        mkdir -p 1_data/deriv/fmriprep/$subj/$onfunc
        touch 1_data/deriv/fmriprep/$subj/$onfunc/.gitkeep
    done 
done
