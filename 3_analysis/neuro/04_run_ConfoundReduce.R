# Dependencies
library(assertthat)
library(dplyr)
library(stringr)
source("/data/tools/stinkR/make_df.R", local = T)

# Identifying where the data exists
path <- "/data/MRI_Final/deriv/pipeline_1/fmriprep/"

# Identifying the different participant IDs
# Pulling each filename in the path
pts <- list.files(path = paste0(path)) %>%
       # Removing any file name that doesn't start with "sub-"
       .[grep(x = ., pattern = "^sub-*")] %>%
       # Removing any characters beyond the first 7 of each filename (removes the ".html")
       str_extract(pattern =".......") %>%
       # Removing dupliate names
       unique()

# Iterating through each of the participants
for (i in pts){
  
  # Iterate through the runs in the study
  for (j in paste0("run-",1:5)){
    
    # Create a variable to capture the file name for this run
    filename <- paste0(path, i, "/func/", i, "_task-trust_", j,"_desc-confounds_timeseries.tsv")
    
    # Check whether this file exists, and if it doesn't, print an error and give up.
    if (!file.exists(filename)){
      print(paste("Error:", i, "'s", j, "file could not be located"))
    }
    
    # If it does exist . . . 
    if (file.exists(filename)){
      
      # Check if the file is empty
      if (file.info(filename)$size <= 0){
        print(paste("Error:", i,"'s ", j,"file does not contain data"))
      }
      
      # And if the file isn't empty . . .
      if (file.info(filename)$size > 0){
        
        # Read in the file as a dataframe
        df <- read.table(file = filename,
                         sep = '\t',
                         header = T,
                         na.strings = c("","NA","n/a"))
        
        # List of confounds
        confounds <- c("a_comp_cor_00","a_comp_cor_01","a_comp_cor_02","a_comp_cor_03",
                       "a_comp_cor_04","a_comp_cor_05", names(df)[grep(x= names(df), pattern = "^cosine*")],
                       "trans_x","trans_y", "trans_z","rot_x","rot_y","rot_z", "framewise_displacement")
        
      
        # Subset the desired columns
        df <- subset(df, select = confounds)
        
        # And then save that dataframe as a new text file within that "look_onsets" folder
        write.table(df, 
                    file = paste0(path, i, "/func/", i, "_task-trust_", j,"_desc-confounds_timeseries_reduced.tsv"), 
                    sep = "\t",
                    row.names = FALSE,
                    col.names = TRUE)
      }
    } 
  }
}