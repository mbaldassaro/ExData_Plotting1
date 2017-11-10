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
hpc2 <- read_delim("household_power_consumption.txt", delim=";", na="?")
hpc2$Date <- dmy(hpc2$Date); 
hpc2 <- filter(hpc2, Date=="2007-02-01" | Date=="2007-02-02") 
hpc2 <- mutate(hpc2, DT=as.POSIXct(ymd(Date) + hms(Time)))

#Create + save plot
dev.copy(png, "plot2.png", width=480, height=480)
plot(hpc2$DT, hpc2$Global_active_power, type="l" ,lwd=1, xlab="", ylab="Global Active Power (kilowatts)")
dev.off()