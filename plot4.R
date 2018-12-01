# Load relevant packages & files
library(dplyr)
data <- read.table("household_power_consumption.txt", header = TRUE, 
                   sep = ";", na.strings = "?")

# Redine date and time & filter for dates of interest
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
targetData <- filter(data, Date >= "2007-02-01" & Date <= "2007-02-02")
targetData$datetime <- strptime(paste(targetData$Date, targetData$Time), "%Y-%m-%d %H:%M:%S")
targetData$datetime <- as.POSIXct(targetData$datetime)

# Build the panel of graphics

par(mfrow = c(2,2))
attach(targetData)
plot(Global_active_power ~ datetime, type = "l", ylab = "Global Active Power", 
     xlab = "")
plot(Voltage ~ datetime, type = "l")
plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering", 
     xlab = "")
lines(Sub_metering_2 ~ datetime, col = "Red")
lines(Sub_metering_3 ~ datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")
plot(targetData$datetime,as.numeric(as.character(targetData$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")

# Save as PNG file with specified dimensions

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
detach(targetData)