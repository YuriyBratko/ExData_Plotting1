## Assuming .txt file downloaded and extracted from archive by previous plot, plot1.R

## Recover data only for the dates 2007-02-01 and 2007-02-02
# Calculate first row where the needed date is appearing
subset_start <- grep("^1/2/2007", readLines("household_power_consumption.txt"))[1]
# Calculate the number of rows to extract
subset_length <- length(grep("^[1-2]/2/2007", readLines("household_power_consumption.txt")))
# Extract column names
column_names <- read.table("household_power_consumption.txt", sep = ";", nrows = 1)
# Extract subset_length number of rows from the txt file subset_start line. Apply column names 
data <- read.table("household_power_consumption.txt", skip=subset_start, nrows=subset_length, sep = ";", na.strings = "?", col.names = as.character(unlist(column_names[1,])))

# Convert date and time to POSIXlt and paste to a new column
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Create plot. Save as .png
png(filename = "plot3.png")
plot(data$DateTime, data$Sub_metering_1, type = "n", ylab="Energy sub metering", xlab = "")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black","red", "blue"), legend = colnames(data[7:9]))
dev.off()