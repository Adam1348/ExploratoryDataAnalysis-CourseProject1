library(lubridate)
library(chron)

#Download the data
url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url,destfile='./power_consumption.zip')
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
png(filename = "plot4.png")
par(mfrow = c(2, 2))
#First
plot(data$DateTime, data$Global_active_power, xlab = "", 
     ylab = "Global Active Power (kilowatts)", type = "l")
#Second
plot(data$DateTime, data$Voltage, xlab = "datetime", ylab = "Voltage (Volt)", type = "l")
#Thrid
plot(data$DateTime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(data$DateTime, data$Sub_metering_2, col = "Red")
lines(data$DateTime, data$Sub_metering_3, col = "Blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1, col = c("Black", "Red", "Blue"))
#Fourth
plot(data$DateTime, data$Global_reactive_power, xlab = "datetime",
     ylab = "Global_Reactive_Power", type = "l")

dev.off()
