
## Read in data; truncate at 70,000 observations because we know from
## computing dateIndexes afterwards that the dates we are concerned with---
## 1/2/2007,2/2/2007---do not extend beyond row 70,000.
hpc <- read.table("household_power_consumption.txt",
                  header=TRUE, sep=";", nrows=70000)
dateIndexes <- which(hpc$Date=='1/2/2007' | hpc$Date=='2/2/2007')
hpc <- hpc[dateIndexes,]


## coerce other relevant columns to proper types
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))


## Build plot in a png file device
png("plot1.png")

par(mfcol=c(1,1))
par(cex=1,font=2)

hist(hpc$Global_active_power, main="Global Active Power", xlab="",
     ylab="", col="#FF2500")

par(font=1)

mtext("Global Active Power (kilowatts)", side=1, line=3, cex=1)
mtext("Frequency", side=2, line=3, cex=1)

## close
dev.off()
