#!/usr/bin/env python

from nilearn import plotting
import matplotlib.pyplot as plt
from scipy.stats import norm
import nibabel as nib

fsl_z_map = nib.load('/data/MRI_Final/deriv/pipeline_1/fmriprep/ThirdLvl_DMN/cope1.gfeat/cope1.feat/thresh_zstat3.nii.gz')

coords = [(0, -54, 26)]

display = plotting.plot_glass_brain(fsl_z_map, colorbar=True, threshold=norm.isf(0.001),title='FSL Z Map', plot_abs=False, display_mode='ortho')
display.add_markers(marker_coords=coords, marker_color = 'g', marker_size=200)

#save it
display.savefig('/data/MRI_Final/deriv/pipeline_1/fmriprep/ThirdLvl_DMN/cope1.gfeat/seed_correlation_DMN_cope1_zstat1.pdf')