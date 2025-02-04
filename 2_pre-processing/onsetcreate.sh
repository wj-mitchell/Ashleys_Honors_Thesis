#!/bin/bash

# Directory containing the subject folders
subjects_dir="1_data/deriv/fmriprep"  # Update with the path to the directory containing subject folders

# Loop through each subject directory
for subject_dir in "$subjects_dir"/*; do
    if [ -d "$subject_dir" ]; then
        output_file="$subject_dir/onset/output.txt"  # Define the output file path

        # Create the new output.txt file and write the contents
        echo -e "90\t1338\t1.0" > "$output_file"  # Overwrite or create the output.txt file with the content
        echo "Created or updated $output_file"
    fi
done