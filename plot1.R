#Reading the file from the folder
newFile <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", nrows= 3000000, check.names = FALSE, stringsAsFactors=FALSE)
newFile$Date <- as.Date(newFile$Date, format = "%d/%m/%Y")

#subsetting the data
subFile <- filter(newFile, Date >= as.Date("2007-02-01"), Date < as.Date("2007-02-03"))
rm(newFile)

#Converting the datetime to POSIX format
datetime <- paste(as.Date(subFile$Date),subFile$Time)
subFile$Datetime <- as.POSIXct(datetime)

#Plot the histogram
hist(subFile$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)",col= "red",)
dev.copy(png,file = "plot1.png")
dev.off()
