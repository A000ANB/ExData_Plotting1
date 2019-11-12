## Estimate memory required to load entire csv file
top.size <- object.size(read.csv("household_power_consumption.txt", nrow=1000))
lines <- as.numeric(gsub("[^0-9]", "", system("wc -l household_power_consumption.txt", intern=T)))
size.estimate <- lines / 1000 * top.size
print(paste("To load entire file we will need ", size.estimate))

## Use sqlite to subset data from csv
## and lubridate for date conversion
library(sqldf)
library(lubridate)
query_string<-'select * from file where Date = "1/2/2007" or Date = "2/2/2007"'  
ss2007 <- read.csv.sql(file = "household_power_consumption.txt", sql = query_string, sep=";")
## Retrieved 2880 objs of 9 variables
## Convert characters to Date
ss2007$Date<-dmy(ss2007$Date)
## Create PNG
png(filename="Plot1.png", width=480, height=480)
hist(ss2007$Global_active_power,ylim=c(0,1300), col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
