ATLAS=FILEPATH
FEAT=${DERIV}/sub-${SUBJ}/func/lvl1.feat/
FILE=standardMask2example_func_${ROI}

fslmaths ${ATLAS} -thr ${ROINUM} -uthr ${ROINUM} -bin ${ROI}
flirt -in ${ROI}.nii.gz \
      -ref ${FEAT}/example_func.nii.gz \
      -out ${OUTPUT} \
      -applyxfm \
      -init ${FEAT}/reg/standard2example_func.mat \
      -datatype float

fslmaths ${OUTPUT} \
         -thr 0.5 \
         ${OUTPUT}

fslmaths ${OUTPUT} \
         -bin \
         ${OUTPUT}  