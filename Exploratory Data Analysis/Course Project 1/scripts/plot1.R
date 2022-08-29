## Begin by loading in the data and filtering it down to the specified dates (Feb 1st and 2nd, 2007)
data <- read.table("data/household_power_consumption.txt", header = TRUE, sep = ";")
data <- data[data$Date == "1/2/2007"|data$Date == "2/2/2007",]

## Open a png graphical device. Default values suffice. 
png("plots/plot1.png")

## Make the graph. "main" is the chart title, "xlab" the x-axis label, "col" is the color of the graph
hist(as.numeric(data$Global_active_power), main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

## Close the graphical device, saving the file.
dev.off()