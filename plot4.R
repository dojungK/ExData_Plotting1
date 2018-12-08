# Read txt file
afile <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ",", colClasses = c(rep("character", 9)))

# Get subset for requested dates
afile$Date <- as.Date(afile$Date, format = "%d/%m/%Y")
df1 <- subset(afile, Date == "2007-02-01")
df2 <- subset(afile, Date == "2007-02-02")
df <- rbind(df1, df2)

# Set col classes
a <- 3:9
for(i in a) {
  df[, i] <- as.numeric(df[, i])
}

# Add new col combining Date and Time
nt <- strptime(paste(df$Date, df$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S", tz = "GMT")
nf <- cbind(nt, df)

# Start png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Draw plot4
par(mfrow = c(2,2))

#4-1
with(nf, plot(nt, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

#4-2
plot(nf$nt, nf$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#4-3
plot(nf$nt, nf$Sub_metering_1, type = "l", xlab = "", ylab = "")
points(nf$nt, nf$Sub_metering_2, type = "l", col = "red", xlab = "", ylab ="")
points(nf$nt, nf$Sub_metering_3, type = "l", col = "blue", xlab = "", ylab = "")
title(xlab = "", ylab = "Energy sub metering")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), bty = "n")

#4-4
plot(nf$nt, nf$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Save png file
dev.off()