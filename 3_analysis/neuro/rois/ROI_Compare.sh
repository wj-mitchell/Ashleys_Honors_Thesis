fslhd roi_mPFC_bin.nii.gz >> roi_mPFC.txt
fslhd roi_mPFCv2_bin.nii.gz >> roi_mPFCv2.txt
fslhd roi_amyg_bin.nii.gz >> roi_amyg.txt
# diff roi_amyg.txt roi_mPFC.txt
diff roi_amyg.txt roi_mPFCv2.txt