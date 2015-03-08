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
png("plot1.png")
hist(d$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
