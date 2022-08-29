## Begin by loading in the data and filtering it down to the specified dates (Feb 1st and 2nd, 2007)
data <- read.table("data/household_power_consumption.txt", header = TRUE, sep = ";")
data <- data[data$Date == "1/2/2007"|data$Date == "2/2/2007",]

## Add in a datetime column for plotting against
data$Datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

## Open a png graphical device. Default values suffice. 
png("plots/plot3.png")

## Make the graph. Matplot here allows for easy graphing of multiple pieces of data against a single reference vector. 7, 8, and 9 happen
matplot(data$Datetime, data[,7:9], type = "l", xlab = "", ylab = "Energy sub metering", col = c("black", "red", "blue"), lwd = 1, lty = "solid")

## And create the legend
legend("topright", pch = 19, col = c("black", "red", "blue"), legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))

## Close the graphical device, saving the file.
dev.off()