library("data.table")

# Imports data from a file and extracts a subset based on specified dates.
dataframe <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Suppresses the display of the histogram in scientific notation.
dataframe[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Enabling filtering and graphing by time of day for a POSIXct date.
dataframe[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Apply a filter to select dates on February 1st and February 3rd, 2007.
dataframe <- dataframe[(dateTime >= "2007-02-01") & (dateTime <= "2007-02-03")]
dataframe[, day := weekdays(as.Date(dateTime, format = "%d/%m/%Y"))]

png("plot2.png", width=480, height=480)

## 2nd plot
plot(x = dataframe[, dateTime], y = dataframe[, Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()