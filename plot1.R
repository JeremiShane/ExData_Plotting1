## by Jeremi Summerhill
## Exploratory Data Analysis on Coursera
## Week 1 peer graded assignment
## plot1.R produces a histogram of 2/1-2/2/2007 Electric Power Usage

plot1 <- function(datadir=getwd(), writedir=getwd()){
        ## library(plyr)  ## load library plyr before dplyr
        ## library(dplyr)
        
        d <- paste(datadir, "/household_power_consumption.txt", sep="")
        dfelectric <- read.table(d, sep=";", header=TRUE, strip.white=TRUE, dec=".", na.strings="?", colClasses="character", numerals="no.loss")
        
        dt <- paste(dfelectric$Date, dfelectric$Time)
        dfelectric$datetime <- strptime(dt, format="%d/%m/%Y %H:%M:%S")
        dfelectric <- dfelectric[dfelectric$datetime >= "2007-02-01 00:00:00" & dfelectric$datetime <= "2007-02-02 23:59:00", ]
        ##dfelectric
        png(file="plot1.png", width=480, height=480)
        gap <- as.numeric(dfelectric$Global_active_power)
        hist(gap, col="red", xlab="Global Active Power(Kilowatts)", main="Global Active Power")
        dev.off()
        dfelectric
}