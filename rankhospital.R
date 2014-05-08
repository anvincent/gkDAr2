rankhospital <- function(state, outcome, num = "best") {
  ## Initialize vars, allowable values, error texts
  q <- "Hospital.30.Day.Death..Mortality..Rates.from."
  qHAttack <- c("Heart.Attack","Heart Attack","heart attack")
  qHFailure <- c("Heart.Failure","Heart Failure","heart failure")
  qPneumonia <- c("Pneumonia","pneumonia")
  e2 <- "invalid state"
  e3 <- "invalid outcome"
  
  ## Read outcome data - based on specs convert columns to numeric
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  for(i in c(11,13,14,17,19,20,23,25,26,29,31,32,35,37,38,41,43,44)) {
    df[,i] <- suppressWarnings(as.numeric(df[,i]))
  } 
  
  ## Check that state and outcome are valid
  ## State - see if the state submitted is a part of the dataset
  if(state %in% unique(df$State)) {
    df <- df[df$State==state,]
  } else {stop(e2)}
  
  ## outcome - see which one we're using based on a list of acceptable values
  if(outcome %in% qHAttack) {
    outcomeToTest <- "Heart.Attack"
  } else if (outcome %in% qHFailure) {
    outcomeToTest <- "Heart.Failure"
  } else if (outcome %in% qPneumonia) {
    outcomeToTest <- "Pneumonia"
  } else {stop(e3)}
  outcomeToTest <- paste(q,outcomeToTest,sep="")
  
  rm(q,e2,e3,qHAttack,qHFailure,qPneumonia)         # clean
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  df <- df[order(df[[outcomeToTest]],df$Hospital.Name),]
  df <- na.omit(df)
  if(num == "best") {num = 1}
  if(num == "worst") {num = as.numeric(nrow(df))}
  if(nrow(df) < num) {
    result <- "NA"
  } else {
    result <- df[num,]$Hospital.Name
  }
  result
}