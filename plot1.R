setwd("C:\\Users\\Risa\\Documents\\R\\Coursera R Directory\\Exploratory Data Analysis\\Week 1")

## load data
dataSet <- read.table("household_power_consumption.txt", header=T, sep = ";", skip = 1)
names(dataSet) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", 
                    "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

## subset dates (2/1/2007-2/2/2007)
dataSubset <- subset(dataSet, dataSet$date=="1/2/2007" | dataSet$date== "2/2/2007")
dataFixed <- transform(dataSubset, global_active_power = as.numeric(global_active_power))

## graph
png(filename = "plot1.png", width=480, height=480)
hist(dataFixed$global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col="Red")
dev.off()