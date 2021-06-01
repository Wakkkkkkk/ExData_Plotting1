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

# create the second graph
png("plot2.png")
# Main trouble here was getting the combined date variable before. Everything else is easy
with(twodays, plot(Pstd,Global_active_power, type="l", ylab = "Global Active Power (kilowatts)"))
dev.off()

# create the third graph
png("plot3.png")
with(twodays, plot(Pstd,Sub_metering_1, type="n", ylab = "energy sub metering"))
with(twodays, lines(Pstd, Sub_metering_1))
with(twodays, lines(Pstd, Sub_metering_2, col="red"))
with(twodays, lines(Pstd, Sub_metering_3, col="blue"))
with(twodays, legend("topright",col=c("black","red","blue"), lty = c(1,1,1), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")))
dev.off()

# create the fourth graph
png("plot4.png")
par(mfrow=c(2,2))

with(twodays, plot(Pstd,Global_active_power, type="l", ylab = "Global Active Power (kilowatts)"))

with(twodays, plot(Pstd,Voltage, type="l", xlab = "datetime"))

with(twodays, plot(Pstd,Sub_metering_1, type="n", ylab = "energy sub metering"))
with(twodays, lines(Pstd, Sub_metering_1))
with(twodays, lines(Pstd, Sub_metering_2, col="red"))
with(twodays, lines(Pstd, Sub_metering_3, col="blue"))
with(twodays, legend("topright",col=c("black","red","blue"), lty = c(1,1,1), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")))

with(twodays, plot(Pstd,Global_reactive_power, type="l", xlab = "datetime"))

dev.off()