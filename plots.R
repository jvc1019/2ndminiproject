# CMSC 197 (Introduction to Data Science)
# SECOND MINI PROJECT
#
# Submitted by: JAYVEE B. CASTAÑEDA
# B.S. in Computer Science - IV, UPV

# Problem 2

# Make sure that the "plots.R" file is outside the folder named
#             "household_power_consumption_data"
# which contains the 'household_power_consumption.txt' file.

# Change working directory
directory <- "./household_power_consumption_data"
setwd(directory)

# Read the 'household_power_consumption.txt' file
table_data = read.table('household_power_consumption.txt', header=TRUE, sep = ";", na.strings = "?")

# Convert the character string found under column "Date" to a class type Date
table_data$Date <- as.Date(table_data$Date, "%d/%m/%Y")

# Now that each row has a date, we should filter the given data set to only include rows from February 1, 2007 to February 2, 2007
table_data <- subset(table_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Remove all the rows with missing values as denoted by "?"
table_data <- table_data[complete.cases(table_data),]

# Merge the Date and Time columns into one
date_time <- paste(table_data$Date, table_data$Time)
date_time <- setNames(date_time, "DateTime")
table_data <- table_data[ ,!(names(table_data) %in% c("Date","Time"))]
table_data <- cbind(date_time, table_data)

## Change the format in the 'date_time' Column
table_data$date_time <- as.POSIXct(date_time)

# Plot 1
hist(table_data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

# Save Plot 1 into a PNG file
dev.copy(png, file="plot1.png", height=1000, width=1000)
dev.off()

# Plot 2
plot(table_data$Global_active_power~table_data$date_time, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# Save Plot 2 into a PNG file
dev.copy(png, file="plot2.png", height=1000, width=1000)
dev.off()

# Plot 3
with(table_data, {
  plot(Sub_metering_1~date_time, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~date_time,col='Red')
  lines(Sub_metering_3~date_time,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save Plot 3 into a PNG file
dev.copy(png, file="plot3.png", height=1000, width=1000)
dev.off()

# Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(table_data, {
  plot(Global_active_power~date_time, type="l", ylab="Global Active Power", xlab="") # Top Left Plot, Similar to Plot 2
  
  plot(Voltage~date_time, type="l", ylab="Voltage", xlab="") # Top Right Plot
  
  # Bottom Left Plot, Similar to Plot 3
  plot(Sub_metering_1~date_time, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~date_time,col='Red')
  lines(Sub_metering_3~date_time,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power~date_time, type="l", ylab="Global_reactive_Power",xlab="") # Bottom Right Plot
})

# Save Plot 4 into a PNG file
dev.copy(png, file="plot4.png", height=1000, width=1000)
dev.off()