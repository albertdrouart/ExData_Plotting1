## Plot 1

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

## plot 1 - histogram of Global Active Power
par(mfrow=c(1,1))
hist(powerData$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()