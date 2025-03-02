#!/bin/bash

# Directory containing the subject folders
SUBJECTS=`cat /data/Ashleys_Honors_Thesis/3_analysis/neuro/particpants.txt`

# Loop through each subject
for subject_dir in ${SUBJECTS}; do
    
    echo "Working on ${subject_dir}"

    output_file=/data/Ashleys_Honors_Thesis/1_data/deriv/fmriprep/${subject_dir}/onset/output.txt

    case "$subject_dir" in

        sub-0035 | sub-4590 | sub-6943 | sub-6799 | sub-6977 | sub-8746 | sub-5006 )

            # Create the new output.txt file and write the contents
            echo -e "90\t1338\t1.0" > "$output_file"  # Overwrite or create the output.txt file with the content
            echo "Created or updated $output_file" ;;

        * )

            # Create the new output.txt file and write the contents
            echo -e "60\t1338\t1.0" > "$output_file"  # Overwrite or create the output.txt file with the content
            echo "Created or updated $output_file" ;;
    esac

done