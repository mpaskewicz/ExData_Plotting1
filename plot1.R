# Load relevant packages & files
library(dplyr)
data <- read.table("household_power_consumption.txt", header = TRUE, 
                   sep = ";", na.strings = "?")

# Redefine Date variable & filter for dates of interest
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
targetData <- filter(data, Date >= "2007-02-01" & Date <= "2007-02-02")
targetData$datetime <- strptime(paste(targetData$Date, targetData$Time), "%Y-%m-%d %H:%M:%S")

# Build the graphic

attach(targetData)
hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

# Save as PNG file with specified dimensions

dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
detach(targetData)