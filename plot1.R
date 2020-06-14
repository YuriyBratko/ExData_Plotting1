## Download and unzip data for the project
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile ="Dataset.zip", method = "curl")
unzip("Dataset.zip")
## Remove .zip archive
file.remove("Dataset.zip")

## Recover data only for the dates 2007-02-01 and 2007-02-02
# Calculate first row where the needed date is appearing
subset_start <- grep("^1/2/2007", readLines("household_power_consumption.txt"))[1]
# Calculate the number of rows to extract
subset_length <- length(grep("^[1-2]/2/2007", readLines("household_power_consumption.txt")))
# Extract column names
column_names <- read.table("household_power_consumption.txt", sep = ";", nrows = 1)
# Extract subset_length number of rows from the txt file subset_start line. Apply column names 
data <- read.table("household_power_consumption.txt", skip=subset_start, nrows=subset_length, sep = ";", na.strings = "?", col.names = as.character(unlist(column_names[1,])))

# Create plot. Save as .png
png(filename = "plot1.png")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab="Global Active Power (kilowatts)", breaks = 12)
dev.off()
