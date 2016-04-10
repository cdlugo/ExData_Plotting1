library(dplyr)
library(lubridate)

# Load and format the data
power_consumption <- read.delim("household_power_consumption.txt", sep = ";", colClasses = c(rep_len("character", 2), rep_len("numeric", 7)), na.strings = "?")
time_interval <- interval(ymd("2007-02-01"), ymd("2007-02-02"))
power_consumption <- power_consumption %>%
  mutate(DateTime = dmy_hms(paste(Date, Time)), Date = dmy(Date)) %>%
  filter(Date %within% time_interval)

# Create the graphic
png("plot4.png")
par(mfcol = c(2, 2))

# Top left (also plot 2)
with(power_consumption, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

# Bottom left (also plot 3)
with(power_consumption, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(power_consumption, lines(DateTime, Sub_metering_2, col = "red"))
with(power_consumption, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"))

# Top right
with(power_consumption, plot(DateTime, Voltage, type = "l", xlab = "datetime"))

# Bottom right
with(power_consumption, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()