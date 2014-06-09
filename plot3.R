## download the zip file to the working directory
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile='./data.zip')

## unzip the file into the working directory
unzip(paste(getwd(), '/data.zip', sep=''))

## read the data .csv
install.packages('data.table', destdir=getwd())
library(data.table)
data <- fread('household_power_consumption.txt', sep=';')

## subset the data to focus on 1st and 2nd february 2007
data <- subset(data, data$Date == '1/2/2007' | data$Date=='2/2/2007')

## convert time
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
data$DateTime <- as.POSIXct(paste(data$Date, data$Time))

## plot3
par(mfrow = c(1,1))

plot(data$DateTime, data$Sub_metering_1, type='l',xlab='', ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, type='l', col='red')
lines(data$DateTime, data$Sub_metering_3, type='l', col='blue')
legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd='1', col=c('black', 'red', 'blue'))

## copy graph to a png file
dev.copy(png, file='plot3.png', width=480, height=480)
dev.off()