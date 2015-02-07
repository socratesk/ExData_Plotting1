# Import sqldf library to import data in "SQL-like" manner for given date ranges
library(sqldf)

# ASSUMPTION: The original data is downloaded from internet, Unipped, and located in the Working Directory "C:\\courses\\4-Exploratory Data Analysis\\Project\\data"

# Set working Directory
setwd("C:\\courses\\4-Exploratory Data Analysis\\Project\\data")

# Read data from TXT file for dates 1-Feb-2007 and 2-Feb-2007
data <- read.csv.sql("household_power_consumption.txt", header=TRUE, sep=";", sql="select * from file where Date='1/2/2007' OR Date = '2/2/2007'")

# Combine Date and Time - using POSIXct 
data <- within(data, DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S"))
# Plot PLOT-4. First set layout
layout(matrix(1:4,ncol=2))

# Print first row first column plot
plot(data$Global_active_power ~ data$DateTime, type="l", xlab='', ylab='Global Active Power')

# Print second row first column plot
plot(data$Sub_metering_1 ~ data$DateTime, type="l", xlab='', ylab='Energy sub metering', col='black')
lines(data$Sub_metering_2 ~ data$DateTime, col='red')
lines(data$Sub_metering_3 ~ data$DateTime,col='blue')
legend("topright", legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'), lwd=1.0, cex=1.0)

# Print first row second column plot
plot(data$Voltage ~ data$DateTime, type="l", xlab='datetime', ylab='Voltage')

# Print second row second column plot
plot(data$Global_reactive_power ~ data$DateTime, type="l", xlab='datetime', ylab='Global_reactive_power')

# Printing on an image file
dev.copy(png, file = "plot4.png", bg = "transparent", width=480,height=480)
dev.off()
