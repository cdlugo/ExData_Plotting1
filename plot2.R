library(dplyr)
library(lubridate)

# Load and format the data
power_consumption <- read.delim("household_power_consumption.txt", sep = ";", colClasses = c(rep_len("character", 2), rep_len("numeric", 7)), na.strings = "?")
time_interval <- interval(ymd("2007-02-01"), ymd("2007-02-02"))
power_consumption <- power_consumption %>%
  mutate(DateTime = dmy_hms(paste(Date, Time)), Date = dmy(Date)) %>%
  filter(Date %within% time_interval)

# Create the graphic
png("plot2.png")
with(power_consumption, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()