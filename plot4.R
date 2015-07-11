
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
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))
hpc$Global_reactive_power <- as.numeric(as.character(hpc$Global_reactive_power))
hpc$Voltage <- as.numeric(as.character(hpc$Voltage))
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(as.character(hpc$Sub_metering_3))


## For variety, build plot in screen device, then export

par(mfcol=c(2,2))
par(cex=0.65)

## topleft
plot(hpc$Time, hpc$Global_active_power, xlab= "", ylab=
         "Global Active Power", type='l')

## bottomleft
plot(hpc$Time, hpc$Sub_metering_1, xlab="", ylab=
         "Energy sub metering", type='l', col="black")
lines(hpc$Time, hpc$Sub_metering_2, xlab="", ylab="", type='l', col="red")
lines(hpc$Time, hpc$Sub_metering_3, xlab="", ylab="", type='l', col="blue")

par(cex=0.55)

legend(x="topright", legend=c("Sub_metering_1","Sub_metering_2",
                "Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"), bty="n")

par(cex=0.65)

## topright
plot(hpc$Time, hpc$Voltage, xlab= "datetime", ylab=
         "Voltage", type='l')

## bottomright
plot(hpc$Time, hpc$Global_reactive_power, xlab= "datetime", ylab=
         "Global_reactive_power", type='l')

## export and close
dev.copy(png,"plot4.png",width=480,height=480,units="px")
dev.off()