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
png(filename="Plot2.png", width=480, height=480)
with(ss2007,plot(Global_active_power~Date, type="l",ylab="Global Active Power (kilowatts)"))
dev.off()
