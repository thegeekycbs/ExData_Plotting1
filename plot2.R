#Reading the file from folder
newFile <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", nrows= 3000000, check.names = FALSE, stringsAsFactors=FALSE)
newFile$Date <- as.Date(newFile$Date, format = "%d/%m/%Y")

#subsetting the file
subFile <- filter(newFile, Date >= as.Date("2007-02-01"), Date < as.Date("2007-02-03"))
rm(newFile)

#Converting the datetime into POSIX format
datetime <- paste(as.Date(subFile$Date),subFile$Time)
subFile$Datetime <- as.POSIXct(datetime)

#Ploting the line graph
plot(subFile$Global_active_power~subFile$Datetime, type = "l", ylab ="Global ACtive Power(kilowatts)", xlab="")
dev.copy(png,file="plot2.png")
dev.off()
