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
DateTime <- paste(data$Date, data$Time)
DateTime <- as.POSIXct(DateTime)
DateTime <- setNames(DateTime, "DateTime")
data <- cbind(DateTime, data)

#Plot
png(filename = "plot3.png")
plot(data$DateTime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(data$DateTime, data$Sub_metering_2, col = "Red")
lines(data$DateTime, data$Sub_metering_3, col = "Blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1, col = c("Black", "Red", "Blue"))
dev.off()