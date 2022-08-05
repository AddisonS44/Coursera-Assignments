rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  if(!state %in% data[,"State"]) {
    stop("invalid state")
  }
  
  if (outcome == "heart attack") {
    outcome_col <- 11
  } 
  else if (outcome == "heart failure") {
    outcome_col <- 17
  } 
  else if (outcome == "pneumonia") {
    outcome_col <- 23
  } 
  else {
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with the given rank
  state_filtered <- data[data[,"State"] == state,]
  
  state_filtered <- state_filtered[state_filtered[,outcome_col] != "Not Available",] ## Filter out NAs!
  
  state_filtered <- state_filtered[
    order(as.numeric(state_filtered[,outcome_col]), state_filtered[,2]),
  ]
  
  if (num == "best") {
    num <- 1
  }
  else if (num == "worst") {
    num <- dim(state_filtered)[1]
  }
  ## 30-day death rate
  state_filtered[num,2]
}