## Prepare and Read Input

#Check if file exist in current directory
if (!file.exists('./household_power_consumption.txt')) {
  
  #if file does not exist already in directly download from the internet
  file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(file.url,destfile='./power_consumption.zip')
  
  #unzip file
  unzip('./power_consumption.zip',overwrite=TRUE)
}

#File is available

#Define Column classes
colClasses <- c("character", "character", rep("numeric",7))

#Read Raw Data
raw_data <- read.csv("household_power_consumption.txt",colClasses,sep=";",na="?")

#Filter to only include data from the specified time period
filtered_data <- subset(raw_data, Date %in% c("1/2/2007","2/2/2007"))

#Add DateTime period based on the Date and Time columns 
filtered_data$DateTime <- strptime(
  paste(filtered_data$Date,filtered_data$Time), 
  "%d/%m/%Y %H:%M:%S"
)

## Plot Graph

png("plot4.png", width=480, height=480)
par(mfcol = c(2, 2))
with(filtered_data, {
  
  ## Top Left
  plot(DateTime, Global_active_power,
       xlab = "",
       ylab = "Global Active Power",
       type = "l"
  )
  
  ## Bottom Left
  plot(DateTime, Sub_metering_1, 
       xlab = "",
       ylab = "Energy sub metering",
       col = "Black",
       type = "l"
  )
  lines(DateTime, Sub_metering_2,
        col = "Red"
  )
  lines(DateTime, Sub_metering_3,
        col = "Blue"
  )
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("Black", "Red", "Blue"),
         lwd = 1,
         bty = "n"
  )
  
  ## Top Right
  plot(DateTime, Voltage,
       xlab = "datetime",
       ylab = "Voltage",
       type = "l"
  )
  
  ## Bottom Right
  plot(DateTime, Global_reactive_power,
       xlab = "datetime",
       ylab = "Global_reactive_power",
       col = "Black",
       type = "l"
  )
})
dev.off()



