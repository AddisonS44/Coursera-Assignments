rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that and outcome is valid
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
  
  
  
  collected_output <- data.frame(matrix(ncol = 2, nrow = 0))
  colnames(collected_output) <- c("Hospital", "State")
  
  ## For each state, find the hospital of the given rank
  for (state in unique(data[,"State"])) {
    data_state <- data[data[,"State"] == state,]
    
    data_state <- data_state[data_state[,outcome_col] != "Not Available",] ## Filter out NAs!
    
    data_state <- data_state[
      order(as.numeric(data_state[,outcome_col]), data_state[,2]),
    ]
    
    
    if (num == "best") {
      rowrow <- 1
    }
    else if (num == "worst") {
      rownum <- dim(data_state)[1]
    } 
    else {
      rownum <- num
    }

    state_hospital <- data_state[rownum,2]
    collected_output[nrow(collected_output) + 1,] <- c(state_hospital, state)
}
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  collected_output <- collected_output[order(collected_output[,"State"]),]
  collected_output
}