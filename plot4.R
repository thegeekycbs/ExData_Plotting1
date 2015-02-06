#Reading the file from the folder
newFile <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", nrows= 3000000, check.names = FALSE, stringsAsFactors=FALSE)
newFile$Date <- as.Date(newFile$Date, format = "%d/%m/%Y")

#Subsetting the required data
subFile <- filter(newFile, Date >= as.Date("2007-02-01"), Date < as.Date("2007-02-03"))
rm(newFile)

#converting the datetime to required format
datetime <- paste(as.Date(subFile$Date),subFile$Time)
subFile$Datetime <- as.POSIXct(datetime)

#plot all the graphs into four different quadrants
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(subFile$Global_active_power~subFile$Datetime, type="l", 
     ylab="Global Active Powe", xlab="")
plot(subFile$Voltage~subFile$Datetime, type="l", 
     ylab="Voltage", xlab="datetime")
plot(subFile$Sub_metering_1~subFile$Datetime, type="l", 
     ylab="Global Active Power", xlab="")
lines(subFile$Sub_metering_2~subFile$Datetime,col='Red')
lines(subFile$Sub_metering_3~subFile$Datetime,col='Blue')
legend("topright", col=c("Black", "Red", "Blue"), lty=1, lwd=1, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(subFile$Global_reactive_power~subFile$Datetime, type="l", 
     ylab="Global_rective_Power",xlab="datetime")

dev.copy(png,file="plot4.png")
dev.off()