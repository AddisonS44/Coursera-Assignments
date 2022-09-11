## Import the data using the suggested readRDS() function
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

## Find all emission sources related to Motor Vehicles
SCC_Vehicle <- SCC[grepl("Vehicle", SCC$EI.Sector, ignore.case = TRUE),]
Vehicle_Codes <- as.character(SCC_Vehicle$SCC)

## ...and filter the data based on that criterion
NEI_Vehicles <- NEI[NEI$SCC %in% Vehicle_Codes,]

## Filter the data down to only Baltimore data (given as fips = 24510)
NEI_Vehicles <- NEI_Vehicles[NEI_Vehicles$fips == "24510",]

## Create a character vector containing all of the distinct years in the dataframe and an empty vector to hold their annual sums
years_Baltimore <- unique(NEI_Vehicles$year)
year_pm2.5_Baltimore <- c()

## For all of the years in present in the data, sum all of the data present for that year and shove it into the data vector
for(i in 1:length(years_Baltimore)) {
  year_sum <- mean(NEI_Vehicles[NEI_Vehicles$year == years_Baltimore[i],]$Emissions)
  year_pm2.5_Baltimore[i] <- year_sum
}

## The above for LA
NEI_Vehicles <- NEI[NEI$SCC %in% Vehicle_Codes,]                ## Reassigning this value to save space in the environment
NEI_Vehicles <- NEI_Vehicles[NEI_Vehicles$fips == "06037",]
years_LA <- unique(NEI_Vehicles$year)
year_pm2.5_LA <- c()

for(i in 1:length(years_LA)) {
  year_sum <- mean(NEI_Vehicles[NEI_Vehicles$year == years_LA[i],]$Emissions)
  year_pm2.5_LA[i] <- year_sum
}

## Create the directory if needed and open a graphical device of type png
if(!file.exists("Plots")) {dir.create("Plots")}
png("plots/plot6.png")

## Plot these four points and make them look pretty.
matplot(years_Baltimore, data.frame(log10(year_pm2.5_Baltimore), log10(year_pm2.5_LA)), pch = c(16, 16), 
        xlab = "Year", ylab = "Log10 of average PM2.5 in Baltimore and LA", main = "Average PM2.5 Pollution in Baltimore and Los Angeles", 
        col = c("#FF6600","Black"))

## Add in a descriptive legend
legend(x = "top", legend = c("Baltimore", "Los Angeles"), pch = c(16, 16), col = c("#FF6600","Black"))

## Add in two simple linear regression lines to show the trends of the data
abline(lm(log10(year_pm2.5_Baltimore) ~ years_Baltimore), col = "#FF6600")
abline(lm(log10(year_pm2.5_LA) ~ years_LA), col = "Black")

## Close the graphic device, saving the plot to a .png
dev.off()