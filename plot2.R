# Load relevant packages & files
library(dplyr)
data <- read.table("household_power_consumption.txt", header = TRUE, 
                   sep = ";", na.strings = "?")

# Redefine Date variable & filter for dates of interest
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
targetData <- filter(data, Date >= "2007-02-01" & Date <= "2007-02-02")
targetData$datetime <- strptime(paste(targetData$Date, targetData$Time), "%Y-%m-%d %H:%M:%S")
targetData$datetime <- as.POSIXct(targetData$datetime)

# Build the graphic

attach(targetData)
plot(Global_active_power~datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")


# Save as PNG file with specified dimensions

dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
detach(targetData)