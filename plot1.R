library("data.table")

dest_dir <- getwd()  # Set the destination directory to the current working directory.

# Imports data from a file and extracts a subset based on specified dates.
dataframe <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Suppresses the display of the histogram in scientific notation.
dataframe[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Convert the Date Column to a Date data type.
dataframe[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Apply a filter to select dates on February 1st and February 2nd, 2007.
dataframe <- dataframe[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## 1st plot
hist(dataframe[, Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()