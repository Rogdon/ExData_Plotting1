#install package if missing
if (!require("data.table")) {
  install.packages("data.table")
}

#install package if missing
if (!require("dplyr")) {
  install.packages("dblyr")
}

#stage the household_power data
data_stg <- fread("./exdata_data_household_power_consumption/household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

#filter for data from "1/2/2007" and == "2/2/2007"
data <- filter(data_stg, Date == "1/2/2007" | Date == "2/2/2007")

# create datetime and convert to Date format
data <- mutate(data, DT= as.POSIXct(paste(Date, Time), "%d/%m/%Y %H:%M:%S", tz = "GMT"))

png(filename="plot1.png", height=480, width=480)  #create png device

#plot histogram of Global Active Power
hist(data[["Global_active_power"]], col = "red", xlab="Global Active Power (kilowatts)", ylab = "Frequency", main= "Global Active Power")

 dev.off() # close png file
