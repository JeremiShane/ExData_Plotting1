## by Jeremi Summerhill
## Exploratory Data Analysis on Coursera
## Week 1 peer graded assignment
## plot2.R produces a line chart of 2/1-2/2/2007 Electric Power Usage

plot2 <- function(datadir=getwd(), writedir=getwd()){
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
        
        png(file="plot2.png", width=480, height=480)
        gap <- as.numeric(dfelectric$Global_active_power)
        ##plot(gap ~ dfelectric$wday, col="red", xlab="Global Active Power(Kilowatts)", main="Global Active Power")
        plot(dfelectric$datetime, dfelectric$Global_active_power, type = "l", ylab="Global Active Power(Kilowatts)", xlab="")
        dev.off()
        dfelectric
}