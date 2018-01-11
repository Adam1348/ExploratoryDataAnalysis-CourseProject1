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
png(filename = "plot2.png")
plot(data$DateTime, data$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()