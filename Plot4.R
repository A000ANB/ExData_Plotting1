## Use sqlite to subset data from csv
## and lubridate for date conversion
library(sqldf)
library(lubridate)
query_string<-'select * from file where Date = "1/2/2007" or Date = "2/2/2007"'  
ss2007 <- read.csv.sql(file = "household_power_consumption.txt", sql = query_string, sep=";")
## Retrieved 2880 objs of 9 variables
## Convert characters date and time
## and put them into same column Date
ss2007$Date<-with(ss2007, as.POSIXct(dmy(Date)+hms(Time)))
## Create PNG file
png(filename="Plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(ss2007,plot(Global_active_power~Date, type="l",
                 ylab="Global Active Power (kilowatts)"))
with(ss2007, plot(Voltage~Date, type="l", 
     ylab="Voltage (volt)", xlab=""))
with(ss2007,plot(Sub_metering_1~Date, type="l",ylab="Energy sub metering", col="black"))
with(ss2007,lines(Sub_metering_2~Date, type="l", col="red"))
with(ss2007,lines(Sub_metering_3~Date, type="l", col="blue"))
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
##4
with(ss2007,plot(Global_reactive_power~Date, type="l", 
     ylab="Global Rective Power",xlab=""))

dev.off()

