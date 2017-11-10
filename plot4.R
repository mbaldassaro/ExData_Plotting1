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
hpc4 <- read_delim("household_power_consumption.txt", delim=";", na="?")
hpc4$Date <- dmy(hpc4$Date); 
hpc4 <- filter(hpc4, Date=="2007-02-01" | Date=="2007-02-02") 
hpc4 <- mutate(hpc4, datetime=as.POSIXct(ymd(Date) + hms(Time)))

#Create + save plot
dev.copy(png, "plot4.png", width=480, height=480)
par(mfrow=c(2,2)) 
plot(hpc4$datetime, hpc4$Global_active_power, type= "l", lwd=1, xlab="", ylab="Global Active Power")  
plot(hpc4$datetime, hpc4$Voltage, type="l", xlab="datetime", ylab="Voltage")   
plot(hpc4$datetime, hpc4$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(hpc4$datetime, hpc4$Sub_metering_2, type="l", col="red")
lines(hpc4$datetime, hpc4$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty="n", col=c("black", "red", "blue")) 
plot(hpc4$datetime, hpc4$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")  
dev.off()
