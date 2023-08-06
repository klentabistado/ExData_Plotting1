library("data.table")

# Imports data from a file and extracts a subset based on specified dates.
dataframe <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Suppresses the display of the histogram in scientific notation.
dataframe[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Enabling filtering and graphing by time of day for a POSIXct date.
dataframe[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
dataframe <- dataframe[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]
dataframe[, day := weekdays(as.Date(dateTime, format = "%d/%m/%Y"))]

png("plot3.png", width=480, height=480)

# 3rd plot
plot(dataframe[, dateTime], dataframe[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(dataframe[, dateTime], dataframe[, Sub_metering_2],col="red")
lines(dataframe[, dateTime], dataframe[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
