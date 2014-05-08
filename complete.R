complete <- function(directory, ID = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
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
  x<-df[goodDF,]
  resultDF <- data.frame(ID=as.numeric(character()),
                         nobs=as.numeric(character()),
                         stringsAsFactors=FALSE)
  for(i in ID) {
    y<-x[x$ID==i,]
    y<-nrow(y)
    insertDF<- data.frame(ID=as.numeric(i),
                          nobs=as.numeric(y),
                          stringsAsFactors=FALSE)
    resultDF<-rbind(resultDF,insertDF)
    rm(insertDF)
  }
  return(resultDF)  
}