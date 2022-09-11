library(ggplot2)
library(gridExtra)

## Import the data using the suggested readRDS() function
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

types <- unique(NEI$type)

for(j in 1:length(types)) { #length(types)
  ## Filter the dataframe down to only the requested type
  NEI_current <- NEI[NEI$type == types[j],]
  
  ## Create a character vector containing all of the distinct years in the dataframe and an empty vector to hold their annual sums
  years <- unique(NEI_current$year)
  year_pm2.5 <- c()
  
  ## Create character vectors to store the 

  ## For all of the years in present in the data, sum all of the data present for that year and shove it into the data vector
  for(i in 1:length(years)) {
    year_sum <- sum(NEI_current[NEI_current$year == years[i],]$Emissions)
    year_pm2.5[i] <- year_sum
  }
  type_plot <- qplot(data = data.frame(x = years, y = year_pm2.5), x, y, xlab = "Years", ylab = "PM 2.5 Pollution", 
                     main = paste("Pollution by year for ", types[j])) + geom_smooth(method = "lm", se = FALSE)
  
  assign(paste(types[j], "_plot", sep = ''), type_plot) ## Dynamically assign the plots to variables using the assign() function (prevents
                                                        ## issues with having to store them all in a list, not optimal tbh)
}

## Create the directory if needed and open a graphical device of type png
if(!file.exists("Plots")) {dir.create("Plots")}
png("Plots/plot3.png")

## The graphs are already made and stored as variables from the for loop, so use grid.arrange() to display them
grid.arrange(POINT_plot, NONPOINT_plot, `ON-ROAD_plot`, `NON-ROAD_plot`, ncol = 2)

## Close the graphic device, saving the plot to a .png
dev.off()