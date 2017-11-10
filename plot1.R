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
hpc <- read_delim("household_power_consumption.txt", delim=";", na="?")
hpc$Date <- dmy(hpc$Date); 
hpc <- filter(hpc, Date=="2007-02-01" | Date=="2007-02-02")

#Create + save plot
dev.copy(png, "plot1.png", width=480, height=480)
hist(hpc$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main = "Global Active Power")
dev.off()