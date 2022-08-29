## Begin by loading in the data and filtering it down to the specified dates (Feb 1st and 2nd, 2007)
data <- read.table("data/household_power_consumption.txt", header = TRUE, sep = ";")
data <- data[data$Date == "1/2/2007"|data$Date == "2/2/2007",]

## Add in a datetime column for plotting against
data$Datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

## Open a png graphical device. Default values suffice. 
png("plots/plot2.png")

## Make the graph. "main" is the chart title, "xlab" the x-axis label, "col" is the color of the graph.
                  ## type = "o" specifies a line graph. pch = "." might be irrelevant.
plot(data$Datetime, data$Global_active_power, type = "o", lwd = 1, pch = ".", xlab = "", ylab = "Global Active Power (kilowatts)")

## Close the graphical device, saving the file.
dev.off()