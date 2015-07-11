
## Read in data; truncate at 70,000 observations because we know from
## computing dateIndexes afterwards that the dates we are concerned with---
## 1/2/2007,2/2/2007---do not extend beyond row 70,000.
hpc <- read.table("household_power_consumption.txt",
                  header=TRUE, sep=";", nrows=70000)
dateIndexes <- which(hpc$Date=='1/2/2007' | hpc$Date=='2/2/2007')
hpc <- hpc[dateIndexes,]


## Prepend dates to Time, and convert to POSIXct
hpc$Date <- as.Date(hpc$Date,format="%d/%m/%Y")
hpc$Date <- as.character(hpc$Date)
hpc$Time <- as.character(hpc$Time)
hpc$Time <- paste(hpc$Date,hpc$Time)
hpc$Time <- as.POSIXct(hpc$Time)


## coerce other relevant columns to proper types
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(as.character(hpc$Sub_metering_3))


## Build plot in a png file device
png("plot3.png", width = 480, height = 480, units = "px")

par(mfcol=c(1,1))
par(cex=1)

plot(hpc$Time, hpc$Sub_metering_1, xlab="", ylab=
         "Energy sub metering", type='l', col="black")
lines(hpc$Time, hpc$Sub_metering_2, xlab="", ylab="", type='l', col="red")
lines(hpc$Time, hpc$Sub_metering_3, xlab="", ylab="", type='l', col="blue")
legend(x="topright", legend=c("Sub_metering_1","Sub_metering_2",
                "Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))

## close
dev.off()