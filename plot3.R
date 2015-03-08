library(lubridate)

# extract data for the dates 2007-02-01 and 2007-02-02 from the dataset
extract_data <- function (file) {
  d1 <- read.csv2(file, nrow = 1)
  t1 <- paste(d1[1,1], d1[1,2])
  tsta <- "01/02/2007"
  tend <- "03/02/2007"
  skip <- as.numeric(difftime(dmy(tsta), dmy_hms(t1), units = "min")) + 1
  nrow <- as.numeric(difftime(dmy(tend), dmy(tsta), units = "min"))
  d <- read.table(file, skip = skip, nrow = nrow, sep = ";")
  names(d) <- names(d1)
  return(d)
}

d <- extract_data("household_power_consumption.txt")
png("plot3.png")
plot(d$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l", xaxt = "n")
axis(1, at = c(0, nrow(d)/2, nrow(d)), labels = c("Thu", "Fri", "Sat"))
lines(d$Sub_metering_2, col = "red")
lines(d$Sub_metering_3, col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
