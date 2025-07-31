#!/bin/bash

# Input atlas file
atlas_file="Schaefer2018_200Parcels_7Networks_order_FSLMNI152_2mm.nii.gz"

# Directory containing tSNR maps
tsnr_dir="./tsnr_results"

# Output CSV file
output_csv="roi_tsnr_results.csv"

# Check if the atlas file exists
if [[ ! -f $atlas_file ]]; then
  echo "Error: Atlas file $atlas_file not found!"
  exit 1
fi

# Check if the tSNR directory exists
if [[ ! -d $tsnr_dir ]]; then
  echo "Error: tSNR directory $tsnr_dir not found!"
  exit 1
fi

# Initialize the output CSV file
echo "Filename,ROI,Mean_tSNR" > "$output_csv"

# Loop through each tSNR file in the directory
for tsnr_file in "$tsnr_dir"/*_tsnr.nii.gz; do
  if [[ -f $tsnr_file ]]; then
    echo "Processing $tsnr_file..."

    # Loop through each ROI in the atlas
    for roi in $(seq 1 200); do
      # Extract the mean tSNR for the current ROI
      mean_tsnr=$(fslstats "$tsnr_file" -k "$atlas_file" -l $((roi-1)) -u $roi -M)

      # Append the result to the output CSV
      echo "$(basename "$tsnr_file"),ROI_$roi,$mean_tsnr" >> "$output_csv"
    done
  else
    echo "Skipping invalid file: $tsnr_file"
  fi
done

echo "ROI-based tSNR extraction complete. Results saved to $output_csv."
