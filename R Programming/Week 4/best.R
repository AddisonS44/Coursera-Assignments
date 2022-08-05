best <- function(state, outcome) {
  ## Read the data
  data <- read.csv("outcome-of-care-measures.csv")
  
  ## Throw errors for any bad inputs and determine the relevant 30 day death column
  
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
  
  state_outcome <- data[data[,"State"] == state,]
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  filtered_outcome <- state_outcome[state_outcome[,outcome_col] != "Not Available",] ## Filter out NAs!
  
  sorted_outcome <- filtered_outcome[
    order(as.numeric(filtered_outcome[,outcome_col]), filtered_outcome[,2]),
    ]
  
  head(sorted_outcome[1,2])
}