run_analysis <- function() {
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  #
  # Name:         run_analysis.R
  #
  # Purpose:      The primary function is to obtain the dataset from the 
  #               pre-determined location and convert it to two dataframes, 
  #               based on the parameter passed. One is a merged dataset 
  #               with mean and standard deviation data only. The second is 
  #               with the average of each variable for each activity and 
  #               each subject.
  #
  # Parameters:   Refer to README.md.
  #
  # Inputs:       None.
  #
  # Outputs:      Refer to README.md.
  #
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  
  ### init
  source("data_import_lib.R")
  
  ### properties
  destDir <- "./data"
  
  ## build list of files to import (getZippedData is depreciated)
  fileList <- directoryUpload(destDir)
  setParameters(fileList,1)
  
  ## take files list and import into a single dataframe
  df<-buildData(fileList.Data,fileList.Label,dataGroups)
  
  ## rename columns
  label<-fileUpload(fileList.Label[2])
  df<-renameColumns(df,label)
  
  ## merge activity lables to create core dataset
  label<-fileUpload(fileList.Label[1])
  df<-suppressWarnings(mergeActivityLabels(df,label,c("activity.label","NA.1")))
  
  ## first tidy dataset eliminate columns not needed
  output.index<-carve.mean.std(df,measurements.Data)
  df.tidy1<-df[output.index]
  write.csv(df.tidy1, "./dataset1.csv", row.names=FALSE)
  
  ## second tidy dataset
  library(reshape2)
  df.tidy2.melt<-melt(df.tidy1,id=c("subject.","activity.label.names"))
  df.tidy2.cast<-dcast(df.tidy2.melt,subject. + activity.label.names ~ variable,mean)
  write.csv(df.tidy2.cast, "./dataset2.csv", row.names=FALSE)
  
}