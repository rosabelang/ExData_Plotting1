setwd("C:\\Users\\Risa\\Documents\\R\\Coursera R Directory\\Exploratory Data Analysis\\Week 1")

## load data
dataSet <- read.table("household_power_consumption.txt", header=T, sep = ";", skip = 1)
names(dataSet) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", 
                     "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

dataSubset <- subset(dataSet, dataSet$date=="1/2/2007" | dataSet$date== "2/2/2007")

## convert data types, format
dataFixed <- transform(dataSubset, global_active_power = as.numeric(global_active_power))
dataFixed <- transform(dataFixed, sub_metering_1  = as.numeric(sub_metering_1))
dataFixed <- transform(dataFixed, sub_metering_2  = as.numeric(sub_metering_2))
dataFixed <- transform(dataFixed, voltage  = as.numeric(voltage))
dataFixed <- transform(dataFixed, global_reactive_power  = as.numeric(global_reactive_power))
dataFixed <- transform(dataFixed, date = as.Date(date, format="%d/%m/%Y"))
dataFixed$time <- strptime(dataFixed$time, format = "%H:%M:%S")
dataFixed[1:1440, "time"] <- format(dataFixed[1:1440, "time"], "2007-02-01 %H:%M:%S")
dataFixed[1441:2880, "time"] <- format(dataFixed[1441:2880, "time"], "2007-02-02 %H:%M:%S")

## graph 0
png(filename = "plot4.png", width=480, height=480)
par(mfcol= c(2,2))

## graph 1
plot(dataFixed$time, dataFixed$global_active_power, type = "l", yaxt = "n", xlab = " ", 
     ylab = "Global Active Power")
axis(2, at = c( 0, 1000, 2000, 3000), labels = c(0, 2, 4, 6))

## graph 2
plot(dataFixed$time, dataFixed$sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = " ")
lines(dataFixed$time, dataFixed$sub_metering_2, col = "red")
lines(dataFixed$time, dataFixed$sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"), bty = "n", cex = 0.6)

## graph 3
plot(dataFixed$time, dataFixed$voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## graph 4
plot(dataFixed$time, dataFixed$global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xlab = "datetime")
dev.off()