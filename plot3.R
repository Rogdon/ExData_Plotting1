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

png(filename="plot3.png", height=480, width=480)  #create png device

#plot line chart without axes and outline
plot(data$Sub_metering_1, ylab="Energy sub metering",xlab="",  type="l", axes = FALSE)

box()  #create outline
axis(1, at=c(0, 1440, 2880), lab=c("Thu", "Fri", "Sat"))
axis(2, at=10*0:max(data$Global_active_power))

lines(data$Sub_metering_2, type= "l", col = "red")  #plot Sub_metering_2
lines(data$Sub_metering_3, type= "l", col = "blue") #plot Sub_metering_3

#create Legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        lty = 1, col=c("black", "red", "blue"), cex=0.8)

dev.off() # close png file
