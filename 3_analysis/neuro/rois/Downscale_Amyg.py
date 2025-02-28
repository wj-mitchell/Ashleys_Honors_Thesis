import nibabel as nib
from nilearn.image import resample_to_img

# File paths (modify accordingly)
amygdala_mask_path = "roi_amyg_bin.nii.gz"  # Your 2mm mask
# mni_template_3mm_path = "/usr/local/fsl/data/standard/MNI152_T1_3mm.nii.gz"   # The 3mm template to match
data_template_3mm_path = "/data/Ashleys_Honors_Thesis/1_data/deriv/fmriprep/sub-0295/func/sub-0295_task-uncertainty_run-1_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz"   # The 3mm template to match

# Load the images
amygdala_mask = nib.load(amygdala_mask_path)
# mni_template_3mm = nib.load(mni_template_3mm_path)
mni_template_3mm = nib.load(data_template_3mm_path)

# Resample the 2mm mask to 3mm resolution using nearest-neighbor interpolation
resampled_mask = resample_to_img(
    amygdala_mask, mni_template_3mm, interpolation="nearest"
)

# Save the resampled 3mm mask
output_path = "roi_amyg_bin_3mm.nii.gz"
nib.save(resampled_mask, output_path)

print(f"Resampled amygdala mask saved to {output_path}")