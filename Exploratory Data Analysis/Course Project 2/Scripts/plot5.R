## Import the data using the suggested readRDS() function
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

## Find all emission sources related to Motor Vehicles
SCC_Vehicle <- SCC[grepl("Vehicle", SCC$EI.Sector, ignore.case = TRUE),]
Vehicle_Codes <- as.character(SCC_Vehicle$SCC)

## ...and filter the data based on that criterion
NEI_Vehicles <- NEI[NEI$SCC %in% Vehicle_Codes,]

## Filter the data down to only Baltimore data (given as fips = 24510)
NEI_Vehicles <- NEI_Vehicles[NEI_Vehicles$fips == 24510,]

## Create a character vector containing all of the distinct years in the dataframe and an empty vector to hold their annual sums
years <- unique(NEI_Vehicles$year)
year_pm2.5 <- c()

## For all of the years in present in the data, sum all of the data present for that year and shove it into the data vector
for(i in 1:length(years)) {
  year_sum <- sum(NEI_Vehicles[NEI_Vehicles$year == years[i],]$Emissions)
  year_pm2.5[i] <- year_sum
}

## Create the directory if needed and open a graphical device of type png
if(!file.exists("Plots")) {dir.create("Plots")}
png("plots/plot5.png")

## Plot these four points and make them look pretty.
plot(years, year_pm2.5, pch = 16, xlab = "Year", ylab = "Total PM2.5 Pollution", main = "PM2.5 Pollution by Year for Vehicles in Baltimore")

## Add in a simple linear regression line to show the trend of the data
abline(lm(year_pm2.5 ~ years), col = "blue")

## Close the graphic device, saving the plot to a .png
dev.off()