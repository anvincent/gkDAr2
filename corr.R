corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  library("plyr")
  
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
  goodDF<-complete.cases(df)
  goodDF<-df[goodDF,]
  goodDF<-ddply(goodDF,'ID',function(x) 
                c(count=nrow(x),correlation=cor(x$nitrate,x$sulfate)))
  goodDF<-goodDF[goodDF$count>threshold,]
  goodDF<-as.vector(goodDF$correlation)
  return(goodDF)
}