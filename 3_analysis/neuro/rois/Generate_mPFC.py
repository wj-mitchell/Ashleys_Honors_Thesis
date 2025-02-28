import nibabel as nib
import numpy as np

# Load an MNI 3mm template
mni_template_path = "/data/Ashleys_Honors_Thesis/1_data/deriv/fmriprep/sub-0295/func/sub-0295_task-uncertainty_run-1_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz"  # Ensure this file exists
mni_img = nib.load(mni_template_path)

# Get the affine transformation matrix (maps voxel space to MNI space)
affine = mni_img.affine
shape = mni_img.shape[:3]

# Define MNI coordinates
mni_coords = np.array([1, 55, -3, 1])  # Last 1 is for homogeneous coordinates

# Convert MNI coordinates to voxel indices
inv_affine = np.linalg.inv(affine)
voxel_coords = np.dot(inv_affine, mni_coords)[:3]
voxel_coords = np.round(voxel_coords).astype(int)  # Convert to integer indices

# Create an empty binary mask
mask_data = np.zeros(shape, dtype=np.uint8)

# Define radius in mm and convert to voxels (15mm radius → 5 voxels in 3mm space)
radius_mm = 15
radius_voxels = int(np.round(radius_mm / 3.0))  # ~5 voxels

# Generate a spherical mask
x, y, z = np.ogrid[:shape[0], :shape[1], :shape[2]]
distance = np.sqrt((x - voxel_coords[0])**2 + (y - voxel_coords[1])**2 + (z - voxel_coords[2])**2)
mask_data[distance <= radius_voxels] = 1  # Set voxels within radius to 1

# Create and save the NIfTI mask
mask_img = nib.Nifti1Image(mask_data, affine)
output_path = "roi_mPFCv2_bin_3mm.nii.gz"
nib.save(mask_img, output_path)

print(f"30mm diameter (15mm radius) mask saved to {output_path}")
