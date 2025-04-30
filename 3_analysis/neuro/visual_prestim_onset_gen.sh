#!/bin/bash

# Base directory containing subject directories
DATA="/data/Ashleys_Honors_Thesis/1_data/deriv/fmriprep"

# Loop through each subject directory
for sub_dir in "$DATA"/sub-*; do
    onset_dir="$sub_dir/onset"
    output_file="$onset_dir/output.txt"
    new_file="$onset_dir/visual_prestim.txt"

    # Ensure output.txt exists before processing
    if [[ -f "$output_file" ]]; then
        # Read the first value from output.txt
        first_value=$(awk 'NR==1 {print $1}' "$output_file")

        # Check if the first value is 60 or 90 and write the corresponding data
        if [[ "$first_value" == "60" ]]; then
            echo -e "30\t30\t1\n1398\t30\t1" > "$new_file"
        elif [[ "$first_value" == "90" ]]; then
            echo -e "30\t30\t1\n1458\t30\t1" > "$new_file"
        fi
    fi
done

echo "Processing complete."