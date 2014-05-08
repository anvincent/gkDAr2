rankall <- function(outcome, num = "best") {
  ## Initialize vars, allowable values, error texts
  q <- "Hospital.30.Day.Death..Mortality..Rates.from."
  qHAttack <- c("Heart.Attack","Heart Attack","heart attack")
  qHFailure <- c("Heart.Failure","Heart Failure","heart failure")
  qPneumonia <- c("Pneumonia","pneumonia")
  e1 <- "invalid outcome"
  
  ## Read outcome data - based on specs convert columns to numeric
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  for(i in c(11,13,14,17,19,20,23,25,26,29,31,32,35,37,38,41,43,44)) {
    df[,i] <- suppressWarnings(as.numeric(df[,i]))
  }
  
  ## Check that state and outcome are valid
  ## outcome - see which one we're using based on a list of acceptable values
  if(outcome %in% qHAttack) {
    outcomeToTest <- paste(q,"Heart.Attack",sep="")
  } else if (outcome %in% qHFailure) {
    outcomeToTest <- paste(q,"Heart.Failure",sep="")
  } else if (outcome %in% qPneumonia) {
    outcomeToTest <- paste(q,"Pneumonia",sep="")
  } else {stop(e1)}

  ## For each state, find the hospital of the given rank
  byState <- unique(df$State)
  dfResult <- data.frame(hospital=as.character(), state=as.character(), 
                         stringsAsFactors=FALSE)
  for(i in byState) {                                 # for each State in file    
    dfTmp <- df[df$State==i,]                         # cut down dataframe
    dfTmp <- dfTmp[order(dfTmp[,outcomeToTest],dfTmp["Hospital.Name"]),]
    numBak <- num
    if(num == "best") {num = 1} 
    if(num == "worst") {
      numBak <- num
      num = as.numeric(length(na.omit(dfTmp[[outcomeToTest]])))}
    if(nrow(df) < num) {
      result <- "NA"
    } else {
      dfTmp <- dfTmp[num,]                              # extract ranking
    }
    hospital <- dfTmp["Hospital.Name"]
    state <- i
    dfTmp2 <- data.frame(hospital,state,stringsAsFactors=FALSE)
    dfResult <- rbind(dfResult,dfTmp2)
    num <- numBak
  }
  rownames(dfResult) <- byState
  colnames(dfResult) <- c("hospital","state")
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  dfResult <- dfResult[order(dfResult["state"]),]
  dfResult
}