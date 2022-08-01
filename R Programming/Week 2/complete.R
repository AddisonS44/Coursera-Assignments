## This part of the assignment says to determine the total number of completed rows in each table and output 
## the number of them with the id in a table

complete <- function(Directory, id = 1:332) {
  collected_csv <- NULL
  for(i in id){
    
    if(i < 10){
      datapath <- paste(Directory, "\\00",as.character(i), ".csv", sep= '')
    } else if(i < 100) {
      datapath <- paste(Directory, "\\0",as.character(i), ".csv", sep = '')
    } else {
      datapath<- paste(Directory, "\\", as.character(i), ".csv", sep = '')
    }
    current_csv <- read.csv(datapath)
    
    current_csv <- current_csv[!is.na(current_csv[,"sulfate"]),]
    current_csv <- current_csv[!is.na(current_csv[,"nitrate"]),]
    rowcount <- dim(current_csv)[[1]]
    
    collected_csv <- rbind(collected_csv, c(current_csv[1,"ID"], rowcount))
  }
  colnames(collected_csv)<-c("id", "nobs")
  collected_csv
}