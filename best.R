best <- function(state, outcome) {
  ## Initialize vars, allowable values, error texts
  q <- "Hospital.30.Day.Death..Mortality..Rates.from."
  qHAttack <- c("Heart.Attack","Heart Attack","heart attack")
  qHFailure <- c("Heart.Failure","Heart Failure","heart failure")
  qPneumonia <- c("Pneumonia","pneumonia")
  e1 <- "invalid state"
  e2 <- "invalid outcome"
  
  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  for(i in c(11,13,14,17,19,20,23,25,26,29,31,32,35,37,38,41,43,44)) {
    df[,i] <- suppressWarnings(as.numeric(df[,i]))
  } 
  
  ## Check that state and outcome are valid
  ## State
  if(state %in% unique(df$State)) {
    df <- df[df$State==state,]
  } else {stop(e1)}
  
  ## outcome
  if(outcome %in% qHAttack) {
    outcomeToTest <- "Heart.Attack"
  } else if (outcome %in% qHFailure) {
    outcomeToTest <- "Heart.Failure"
  } else if (outcome %in% qPneumonia) {
    outcomeToTest <- "Pneumonia"
  } else {stop(e2)}
  outcomeToTest <- paste(q,outcomeToTest,sep="")
  
  rm(q,e1,e2,qHAttack,qHFailure,qPneumonia)         # clean

  ## Return hospital name in that state with lowest 30-day death rate
  result <- df[df[[outcomeToTest]] == min(df[[outcomeToTest]],na.rm=TRUE),]
  result <- subset(result,Hospital.Name!="NA")
  result$Hospital.Name
}