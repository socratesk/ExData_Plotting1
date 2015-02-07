# Import sqldf library to import data in "SQL-like" manner for given date ranges
library(sqldf)

# Set working Directory
setwd("C:\\courses\\4-Exploratory Data Analysis\\Project\\data")

# Read data from TXT file for dates 1-Feb-2007 and 2-Feb-2007
data <- read.csv.sql("household_power_consumption.txt", header=TRUE, sep=";", sql="select * from file where Date='1/2/2007' OR Date = '2/2/2007'")

# Combine Date and Time - using POSIXct 
data <- within(data, DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S"))

# Plot PLOT-2 using plot. Use Type=1 for continuous lines instead of circles
plot(data$Global_active_power ~ data$DateTime, type="l", xlab='', ylab='Global Active Power (kilowatts)')

# Printing on an image file
dev.copy(png, file = "plot2.png", bg = "transparent", width=480,height=480)
dev.off()