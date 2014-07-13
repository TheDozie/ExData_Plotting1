## Project 1, Exploratory data analysis
## Read first 2 lines to see initial time/date
## the data file is in the working directory, and output to working directory
testData <- read.csv("household_power_consumption.txt", header=T,sep=";",nrows=2)
## show testData
## testData
## save the column headers
colHeaders <- names(testData)
## get the time of the first reading
firstRecord <- strptime(paste(testData[1,1],testData[1,2]),"%d/%m/%Y %H:%M:%S")
##
## We want to read from 2007-02-01 00:00:00
## So find how many minutes to skip to get to that
startRead <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
skipMinutes <- as.numeric(difftime(startRead,firstRecord,units="min"))
## skipMinutes
## we are to stop reading at 2007-02-02 23:59:00 (before 00:01:00)
## 
## find how many minutes = number of rows
stopRead <- strptime("2007-02-03 00:00:00", "%Y-%m-%d %H:%M:%S")
numRecs <- as.numeric(difftime(stopRead,startRead,units="min"))
## numRecs
## now skip unwanted records and read the required ones
powerReadings <- read.table("household_power_consumption.txt", 
                            header=T,sep=";",skip=skipMinutes,
                            na.strings="?", col.names=colHeaders, 
                            nrows=numRecs)

times <- strptime(paste(powerReadings$Date,powerReadings$Time), 
                  format="%d/%m/%Y %H:%M:%S")
meter1 <- powerReadings$Sub_metering_1
meter2 <- powerReadings$Sub_metering_2
meter3 <- powerReadings$Sub_metering_3

png(filename="plot3.png",width=480,height=480)
par(mfrow=c(1,1))
plot(times, meter1,type="n",ylab="Energy sub metering",xlab="")
lines(times, meter1,type="l",col="black")
lines(times, meter2,type="l",col="red")
lines(times, meter3,type="l",col="blue")
legend("topright",lty=1,col=c("black", "red", "blue"),legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()
