## Write a function called "pollutantmean" which will average the pollutant chosen across all measurements for all monitors in a given range.

## Inputs are the filepath where the data is stored, the pollutant (either sulfate or nitrate), and an integer vector of monitors
## Return the value of all non-NA values

pollutantmean <- function(Directory, pollutant, id = 1:332) {
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
    current_cleaned_csv <- current_csv[!is.na(current_csv[,pollutant]),]
    
    collected_csv <- rbind(collected_csv, current_cleaned_csv)

  }
  mean(collected_csv[,pollutant])
}