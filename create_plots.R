#import packages
library(dplyr)

#get the data into R
if(!exists("hdat")) {
    read.csv("household_power_consumption.txt",na.strings = "?",sep=";")->hdat
}
#select the given 2 days
if(!exists("twodays")){
    hdat[grep("^(1|2)/2/2007$",hdat$Date),1:9] ->twodays
    #pastes together date and time then makes it a standardized time variable
    twodays$Pstd <- strptime(paste(twodays$Date,twodays$Time),"%d/%m/%Y  %H:%M:%S")
    #Pstd stands for pasted data
}

# create the first graph
png("plot1.png")
#Set the color to red, get the titles of each section right, plug in the variable and voila, done
with(twodays, hist(Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)", col="red"))
dev.off()