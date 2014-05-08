pollutantmean <- function(directory, pollutant, ID = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  filenames<-list.files(path=directory, full.names=TRUE)
  df<-read.csv(filenames[1], header=T)
  for(file in filenames) {
    if(file != filenames[1]) {
      tempDF<-read.csv(file, header=T)
      df<-rbind(df,tempDF)
      rm(tempDF)
    }
  }
  rm(file,filenames)
  
  minVal<-min(ID)
  maxVal<-max(ID)
  
  df2<-subset(df,ID >= minVal & ID <= maxVal, select=pollutant)
  result<-signif(mean(df2[[pollutant]],na.rm=TRUE),4)
  rm(df,df2,minVal,maxVal)
  return(result)  
}

