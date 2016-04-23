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

png(filename="plot4.png", height=480, width=480)  #create png device

#create 2x2 empty canvas
par(mfrow = c(2,2))


#plot1 Global Active Power
#plot line chart without axes and outline
plot(data$Global_active_power,  type="l", axes= F, xlab = "", ylab="Global Active Power (kilowatts)")

box()  #create outline
axis(1, at=c(0, 1440, 2880), lab=c("Thu", "Fri", "Sat"))
axis(2, at=2*0:max(data$Global_active_power))


#plot2 Voltage
#plot line chart without axes and outline
plot(data$Voltage,  type="l", axes= F, xlab = "datetime", ylab="Voltage")

box()  #create outline
axis(1, at=c(0, 1440, 2880), lab=c("Thu", "Fri", "Sat"))
axis(2, at=2*0:max(data$Voltage))

#plot3 Energy sub_metering
#plot line chart without axes and outline
plot(data$Sub_metering_1, ylab="Energy sub metering",xlab="",  type="l", axes = FALSE)

box()  #create outline
axis(1, at=c(0, 1440, 2880), lab=c("Thu", "Fri", "Sat"))
axis(2, at=10*0:max(data$Global_active_power))

lines(data$Sub_metering_2, type= "l", col = "red")  #plot Sub_metering_2
lines(data$Sub_metering_3, type= "l", col = "blue") #plot Sub_metering_3

#create Legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        lty = 1, col=c("black", "red", "blue"), cex=0.7, bty="n")



#plot4 Global_reactive_power
#plot line chart without axes and outline
plot(data$Global_reactive_power,  type="l", axes= F, xlab = "datetime", ylab="Global_reactive_power")

box()  #create outline
axis(1, at=c(0, 1440, 2880), lab=c("Thu", "Fri", "Sat"))
axis(2, at=seq(0,max(data$Global_reactive_power), by=0.1))

dev.off() # close png file
