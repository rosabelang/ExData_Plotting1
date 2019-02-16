setwd("C:\\Users\\Risa\\Documents\\R\\Coursera R Directory\\Exploratory Data Analysis\\Week 1")

## load data
dataSet <- read.table("household_power_consumption.txt", header=T, sep = ";", skip = 1)
names(dataSet) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", 
                    "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

## subset dates (2/1/2007-2/2/2007)
dataSubset <- subset(dataSet, dataSet$date=="1/2/2007" | dataSet$date== "2/2/2007")

## convert data types, format
dataFixed <- transform(dataSubset, global_active_power = as.numeric(global_active_power))
dataFixed <- transform(dataFixed, date = as.Date(date))
dataFixed$time <- strptime(dataFixed$time, format = "%H:%M:%S")
dataFixed[1:1440, "time"] <- format(dataFixed[1:1440, "time"], "2007-02-01 %H:%M:%S")
dataFixed[1441:2880, "time"] <- format(dataFixed[1441:2880, "time"], "2007-02-02 %H:%M:%S")

## graph
png(filename = "plot2.png", width=480, height=480)
plot(dataFixed$time, dataFixed$global_active_power, type = "l", yaxt = "n", xlab = " ", 
     ylab = "Global Active Power (kilowatts)")
axis(2, at = c( 0, 1000, 2000, 3000), labels = c(0, 2, 4, 6)) ## specify y-axis
dev.off()