
echo "Creating Point"

fslmaths /usr/local/fsl/data/standard/MNI152_T1_3mm.nii.gz \
         -mul 0 -add 1 \
         -roi 30 1 60 1 23 1 0 1 \
         roi_mPFCv2_point -odt float

echo "Creating Sphere"

fslmaths roi_mPFCv2_point -kernel gauss 15 \
         -fmean -bin roi_mPFCv2_bin -odt float

# echo "Resampling to 3mm"

# flirt -in roi_mPFCv2_bin.nii.gz -ref /usr/local/fsl/data/standard/MNI152_T1_3mm.nii.gz \
#         -applyxfm -usesqform -interp nearestneighbour \
#         -out roi_mPFCv2_bin_3mm.nii.gz

echo "Done!"