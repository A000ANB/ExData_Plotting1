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
png(filename="Plot3.png", width=480, height=480)
with(ss2007,plot(Sub_metering_1~Date, type="l",ylab="Energy sub metering", col="black"))
with(ss2007,lines(Sub_metering_2~Date, type="l", col="red"))
with(ss2007,lines(Sub_metering_3~Date, type="l", col="blue"))
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
