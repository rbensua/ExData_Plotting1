# Plot3.R
# 0. Clear all data
rm(list = ls())
# 1. Reading data:
initial <- read.table( "household_power_consumption.txt",
                      nrows = 100,
                      sep=";", 
                      header = T)
classes <- sapply( initial, class)
fullData <- read.table( "household_power_consumption.txt",
                       header = T,
                       sep = ";", 
                       na.strings = "?",
                       colClasses = classes)
fullData$Date <- paste( fullData$Date, fullData$Time)
fullData$Date <- strptime( fullData$Date, "%e/%m/%Y %H:%M:%S")
# 2. Subsetting
initialDate <- strptime( "2007/02/01 00:00:00", "%Y/%m/%d %H:%M:%S")
endDate <- strptime( "2007/02/02 23:59:00", "%Y/%m/%d %H:%M:%S")

plotData <- subset( fullData, Date <=endDate & Date >= initialDate,
                   select = c(Date, Global_active_power, Global_reactive_power,
                              Voltage, Sub_metering_1, Sub_metering_2,
                              Sub_metering_3))

# 3. Remove all variables except plotData
rm(list = grep( "plotData", ls(), value=T, invert=T))

# 3. Plotting
# Set locale in English for getting the names of the days in english
Sys.setlocale("LC_TIME", "en_US.UTF-8")

png( filename = "plot4.png", width = 480, height = 480)
par(mfrow= c(2,2))
plot(plotData$Date,plotData$Global_active_power,type="l", xlab = "",
     ylab = "Global Active Power (kilowatts)")
plot(plotData$Date,plotData$Voltage,type="l", xlab = "datetime",
     ylab = "Voltage")
plot( plotData$Date, plotData$Sub_metering_1, type="l", xlab = "",
     ylab = "Energy sub metering")
lines( plotData$Date, plotData$Sub_metering_2, col = "red")
lines( plotData$Date, plotData$Sub_metering_3, col = "blue")
legend( "topright", legend = colnames(plotData)[5:7], lty = 1,
       col = c("black","red","blue"),bty = "n")
plot(plotData$Date,plotData$Global_reactive_power,type="l", xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
