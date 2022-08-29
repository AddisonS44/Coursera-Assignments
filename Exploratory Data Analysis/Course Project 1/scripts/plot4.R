## Begin by loading in the data and filtering it down to the specified dates (Feb 1st and 2nd, 2007)
data <- read.table("data/household_power_consumption.txt", header = TRUE, sep = ";")
data <- data[data$Date == "1/2/2007"|data$Date == "2/2/2007",]

## Add in a datetime column for plotting against
data$Datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

## Open a png graphical device. Default values suffice. 
png("plots/plot4.png")

## Set the plot to contain 4 plots, actually
par(mfcol = c(2,2))


## Here is the first graph. "main" is the chart title, "xlab" the x-axis label, "col" is the color of the graph.
## type = "o" specifies a line graph. pch = "." might be irrelevant.
plot(data$Datetime, data$Global_active_power, type = "o", lwd = 1, pch = ".", xlab = "", ylab = "Global Active Power (kilowatts)")


## Here is the second graph, slotted below the first because I used mfcol(). Matplot here allows for easy graphing of multiple pieces of data against a single reference vector. 7, 8, and 9 happen
matplot(data$Datetime, data[,7:9], type = "l", xlab = "", ylab = "Energy sub metering", col = c("black", "red", "blue"), lty = "solid")

legend("topright", pch = 19, col = c("black", "red", "blue"), legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))


## Here is the third graph. Nothing special.
plot(data$Datetime, data$Voltage, type = "l", pch = ".", xlab = "datetime", ylab = "Voltage")

## This is my social security number. No of course not, it's the last graph. What else would go here?
plot(data$Datetime, data$Global_reactive_power, type = "l", pch = ".", xlab = "datetime", ylab = "Voltage")

## Close the graphical device, saving the file.
dev.off()