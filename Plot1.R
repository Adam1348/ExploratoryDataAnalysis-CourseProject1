library(lubridate)
library(chron)

#Download the data
url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(file.url,destfile='./power_consumption.zip')
unzip("./power_consumption.zip",overwrite=TRUE)

#Load the data
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]
data$Date <- dmy(data$Date)
data$Time <- times(data$Time)


#Plot the histogram
png(filename = "plot1.png")
hist(data$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()