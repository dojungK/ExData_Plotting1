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

# Start png file
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Draw plot1
with(df, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power"))

# Save png file
dev.off()
