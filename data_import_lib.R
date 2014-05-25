getZippedData <- function(sourceLink) {
  
  ## properties
  destDir <- paste(getwd(),"/data",sep="")
  outZipFile <- paste(destDir,"/UCIHARDataset.zip",sep="")
  
  if(!file.exists("data")) {
    dir.create("data")
  }
  
  if(!file.exists(outZipFile)) {
    download.file(sourceLink,destfile=outZipFile)
  }
  unzip(outZipFile,exdir=destDir)
  
  fileList <- directoryUpload(destDir)
  return(fileList)
}

substrRight <- function(x, n){substr(x, nchar(x)-n+1, nchar(x))}

substrLeft <- function(x, n){substr(x, 1, n)}

setParameters <- function(fileList,option="full") {
  
  ## properties
  fileLabel <- c("activity.labels","features")
  fileIgnore <- c("features.info","README")
  dataGroups <<- c("test","train")
  groupbuilder <- as.character()
  fullGroups <- c("body.acc","body.gyro","total.acc")
  for(group in fullGroups) {
    for(i in 1:length(dataGroups)) {
      for(dimension in c("x","y","z")) {
        a <- paste(group,dimension,dataGroups[i],sep=".")
        groupbuilder <- append(groupbuilder,a)
      }
    }
  }
  groupbuilder <<- groupbuilder
  
  fileList.Label <<- fileList[(names(fileList) %in% fileLabel)]
  fileList <- fileList[!(names(fileList) %in% fileIgnore)]
  fileList.Data <<- fileList[!(names(fileList) %in% fileLabel)]
  if(option!="full") {
    fileList.Data <<- fileList.Data[!(names(fileList.Data) %in% groupbuilder)]
  }
  
  measurements.Data <<- c("subject.","activity.label.names","mean","std")
  
  ## methods
  
}

directoryUpload <- function(directoryPath="./") {
  
  ## properties
  directories <- list.dirs(path=directoryPath)
  fileList <- as.character()
  df <- as.character()
  
  ## for each directory, get list of files and build an upload template called
  ## fileList to store all files we're going to upload.
  for(directory in directories[2:length(directories)]) {
    for(filenames in (list.files(path=directory,full.names=TRUE))) {
      for(files in filenames) {
        if(!(files %in% directories)) {
          # if the results are not directories, 
          # write full path indexed by the filename
          fileLabel <- strsplit(files,"/")[[1]][length(strsplit(files,"/")[[1]])]
          fileLabel <- substr(gsub("_",".",(fileLabel)),1,
                              nchar(gsub("_",".",(fileLabel)))-4)
          fileList[fileLabel] <- files
        }}}}
  rm(directoryPath,directories,directory,filenames,files)    # clean
  return(fileList)
}

fileUpload <- function(pathToFile,group="") {
  
  ## properties
  colName <- as.character()
  
  firstLineDF <- read.table(pathToFile,sep="",header=FALSE,nrows=1) # get columns
  for(j in 1:ncol(firstLineDF)) {
    colNameCore <- gsub("_",".",(names(pathToFile)))
    if(group!="") {colName[j] <- gsub(group,"",colNameCore)}
    if(ncol(firstLineDF) > 1) {colName[j] <- paste(colName[j],j,sep=".")}
  }
  tempDF <- read.table(pathToFile,sep="",col.names=colName,header=FALSE)
  return(tempDF)
}

buildData <- function(data,labels,groups) {
  dfBuilder <- as.character()
  for(i in 1:length(groups)) {
    dfGroupBuilder <- as.character()
    data2 <- subset(data,substrRight(names(data),nchar(groups[i]))==groups[i])
    for(j in 1:length(data2)) {
      if(substrRight(names(data2[j]),nchar(groups[i]))==groups[i]) {
        tempDF <- fileUpload(data2[j],groups[i])
        if(names(data2[j]) %in% labels) {             # exclude label files
        } else {
          # cbind new DF onto old DF
          if(j==1) {
            dfGroupBuilder <- tempDF
          } else {
            dfGroupBuilder <- cbind(dfGroupBuilder,tempDF)
          }
        }
      }
      
    }
    ## col names are diff - so rbind crashes
    dfBuilder <- rbind(dfBuilder,dfGroupBuilder)
    rm(j,dfGroupBuilder)    
  }
  return(dfBuilder)
}

mergeActivityLabels <- function(df,labels,mergeBy) {
  ## obtain DF and merge activity labels
  resultDF <- merge(df,labels,by.x=mergeBy[1],by.y=mergeBy[2])
  names(resultDF)[names(resultDF)=="NA.2"] <- "activity.label.names"
  
  ## output DF
  return(resultDF)
}

#buildname.renameColumn <- function(label,i=1) {
#  temp <- gsub("-",".",label[2][i,])
#  temp <- gsub("\\(","",temp)
#  temp <- gsub("\\)","",temp)
#  return(temp)
#}

renameColumns <- function(df,label) {
  ## find out which columns to change up
  #count number of fields to cycle through
  for(i in 1:nrow(label[2])) {
    temp <- gsub("-",".",label[2][i,])
    temp <- gsub("\\(","",temp)
    temp <- gsub("\\)","",temp)
    tempName <- paste("X..",i,sep="")
    colnames(df)[colnames(df) == tempName] <- temp
  }
  names(df)[names(df)=="y."] <- "activity.label"
  return(df)
}

carve.mean.std <- function(df,colNames) {
  #build list of column names to keep in data frame
  q <- as.numeric()
  for(i in 1:length(colNames)) {
    q <- append(q, grep(measurements.Data[i],names(df)))
  }
  keep <- q[order(q)]
  #df[keep]
  #return(df)
  return(keep)
}

#build.col.mean <- function(df,columnName) {
#  df<-ddply(df,.(activity.label.names,subject.),function(x) {mean=mean(x[[columnName]],na.rm=TRUE)})
#  return(df)
#}

