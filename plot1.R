# Plot1.R
# 0. Clear all data
rm(list = ls())
# 1. Reading data:
initial <- read.table("household_power_consumption.txt",
                      nrows = 100,
                      sep=";", 
                      header = T)
classes <- sapply(initial,class)
fullData <- read.table("household_power_consumption.txt",
                       header = T,
                       sep = ";", 
                       na.strings = "?",
                       colClasses = classes)
fullData$Date <- paste(fullData$Date,fullData$Time)
fullData$Date <- strptime(fullData$Date,"%e/%m/%Y %H:%M:%S")
# 2. Subsetting
initialDate <- strptime("2007/02/01 00:00:00","%Y/%m/%d %H:%M:%S")
endDate <- strptime("2007/02/02 23:59:00","%Y/%m/%d %H:%M:%S")

plotData <- subset(fullData, Date <=endDate & Date >= initialDate,
                   select = c(Global_active_power))

# 3. Remove all variables except plotData
rm(list = grep("plotData",ls(),value=T,invert=T))

# 3. Plotting
png(filename = "plot1.png",width = 480,height = 480)
hist(plotData$Global_active_power,col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
