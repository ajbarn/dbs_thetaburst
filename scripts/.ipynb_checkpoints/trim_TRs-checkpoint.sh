#!/bin/bash

# Read filenames from filenames.txt
input_file="filelist.txt"

# Check if the file exists
if [[ ! -f $input_file ]]; then
  echo "Error: $input_file not found!"
  exit 1
fi

# Loop through each line in filenames.txt
while read -r nii_file; do
  # Check if the filename ends with .nii or .nii.gz
  if [[ $nii_file == *.nii || $nii_file == *.nii.gz ]]; then
    # Define output filename (e.g., input.nii.gz -> input_trimmed.nii.gz)
    output_file="${nii_file%.nii.gz}_trimmed.nii.gz"
    output_file="${output_file%.nii}_trimmed.nii.gz"

    # Remove the first 5 TRs using fslroi
    echo "Processing $nii_file -> $output_file"
    fslroi "$nii_file" "$output_file" 4 -1

    # Check if fslroi was successful
    if [[ $? -eq 0 ]]; then
      echo "Successfully processed $nii_file"
    else
      echo "Error processing $nii_file"
    fi
  else
    echo "Skipping invalid file: $nii_file"
  fi
done < "$input_file"
