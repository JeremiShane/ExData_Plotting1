## by Jeremi Summerhill
## Exploratory Data Analysis on Coursera
## Week 1 peer graded assignment
## plot3.R produces a line chart comparison of sub_metering of 2/1-2/2/2007 Electric Power Usage

plot3 <- function(datadir=getwd(), writedir=getwd()){
        ## library(plyr)  ## load library plyr before dplyr
        ## library(dplyr)
        library(lubridate)
        
        d <- paste(datadir, "/household_power_consumption.txt", sep="")
        dfelectric <- read.table(d, sep=";", header=TRUE, strip.white=TRUE, dec=".", na.strings="?", colClasses="character", numerals="no.loss")
        
        dt <- paste(dfelectric$Date, dfelectric$Time)
        dfelectric$datetime <- strptime(dt, format="%d/%m/%Y %H:%M:%S")
        dfelectric <- dfelectric[dfelectric$datetime >= "2007-02-01 00:00:00" & dfelectric$datetime <= "2007-02-02 23:59:00", ]
        
        dayofweek <- wday(dfelectric$datetime, label=T)  
        dfelectric$weekday <- dayofweek
        
        png(file="plot3.png", width=480, height=480)
        gap <- as.numeric(dfelectric$Global_active_power)
        ##plot(gap ~ dfelectric$wday, col="red", xlab="Global Active Power(Kilowatts)", main="Global Active Power")
        ##plot(dfelectric$datetime, dfelectric$Global_active_power, type = "l", ylab="Global Active Power(Kilowatts)", xlab="")
        with(dfelectric, plot(datetime, Sub_metering_1, type="l", col="black", ylab="Energy Sub Metering", xlab=""))
        with(dfelectric, points(datetime, Sub_metering_2, type="l", col="red"))
        with(dfelectric, points(datetime, Sub_metering_3, type="l", col="blue"))
        title(xlab="", ylab="Energy Sub Metering")
        legend("topright", seg.len=c(3,3,3), lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        dev.off()
        dfelectric
}