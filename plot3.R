#Automatically download data + load dependencies 

if(!file.exists("household_power_consumption.txt")) {
  fileZip <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileZip, destfile="EPC.zip", method="curl"); 
  unzip("EPC.zip", exdir="./") 
}

list.of.packages <- c("tidyverse","lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]
if(length(new.packages)) install.packages(new.packages)
library(tidyverse); library(lubridate)

#Read in & tidy data  
hpc3 <- read_delim("household_power_consumption.txt", delim=";", na="?")
hpc3$Date <- dmy(hpc3$Date); 
hpc3 <- filter(hpc3, Date=="2007-02-01" | Date=="2007-02-02") 
hpc3 <- mutate(hpc3, datetime=as.POSIXct(ymd(Date) + hms(Time)))

#Create + save plot
dev.copy(png, "plot3.png", width=480, height=480)
plot(hpc3$datetime, hpc3$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(hpc3$datetime, hpc3$Sub_metering_2, type="l", col="red")
lines(hpc3$datetime, hpc3$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()