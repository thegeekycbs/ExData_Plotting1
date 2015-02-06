#Reading the file from the folder
newFile <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", nrows= 3000000, check.names = FALSE, stringsAsFactors=FALSE)
newFile$Date <- as.Date(newFile$Date, format = "%d/%m/%Y")

#Subsetting the required data
subFile <- filter(newFile, Date >= as.Date("2007-02-01"), Date < as.Date("2007-02-03"))
rm(newFile)

#converting the datetime to required format
datetime <- paste(as.Date(subFile$Date),subFile$Time)
subFile$Datetime <- as.POSIXct(datetime)


#plot all the outputs into single a graph
plot(subFile$Sub_metering_1~subFile$Datetime, type = "l", ylab ="Energy sub metering", xlab="")
lines(subFile$Sub_metering_2~subFile$Datetime, col ="Red")
lines(subFile$Sub_metering_3~subFile$Datetime, col ="Blue")

legend("topright", col=c("Black","Red","Blue"), lty = 1, lwd = 1, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png,file="plot3.png")
dev.off()