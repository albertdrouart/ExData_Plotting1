## plot 3

## load library for mutate
library(dplyr)

## establish what lines to skip
test <- grep("(^1/)2/2007", readLines("household_power_consumption.txt"))
skipLines <- test[1] - 1;

## read lines needed - 2880 lines  = 60 min * 24 hours * 2 days
powerData <- read.table("household_power_consumption.txt", sep=";", skip=skipLines, nrows = 2880, header=FALSE)
headers <- read.table("household_power_consumption.txt", sep=";", nrows = 1, header=TRUE)
names(powerData) <- names(headers)

## clear memory
rm(test)
rm(headers)

## mutate -- order matters, convert columns to dates and times
powerData <- mutate(powerData, 
                    Time = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"),
                    Date = as.Date(strptime(Date, "%d/%m/%Y"))
)

##plot 3
par(mfrow=c(1,1))
plot(powerData$Time, powerData$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
lines(powerData$Time, powerData$Sub_metering_2, col = "red")
lines(powerData$Time, powerData$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png")
dev.off()
