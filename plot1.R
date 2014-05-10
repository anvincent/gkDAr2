plot1 <- function(file="household_power_consumption.txt") {
  #### get data, prepare it for plotting
  ## read data from filename. if none given, use default
  df <- read.table(file,sep=";",header=TRUE)
  
  ## convert date field to date data type and subset 2/1 & 2/2
  df$Date <- as.Date(df$Date,format="%d/%m/%Y")
  df <- subset(df,Date >= "2007-02-01" & Date < "2007-02-03")
  
  ## create new field combining date and time
  df$datetime <- strptime(paste(df$Date,df$Time),format="%Y-%m-%d %H:%M:%S")
  
  ## convert remaining fields to their respective data types 
  df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
  df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
  df$Voltage <- as.numeric(as.character(df$Voltage))
  df$Global_intensity <- as.numeric(as.character(df$Global_intensity))
  df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
  df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
  df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
  
  ## define plot properties
  par()                                          # reset parameters
  filename <- "plot1.png"                        # define output filename
  w <- 480                                       # define width
  h <- 480                                       # define height
  u <- "px"                                      # define units
  xLabel <- "Global Active Power (kilowatts)"    # define x axis label
  titleLabel <- "Global Active Power"            # define title label
  colcolor <- "red"                              # define column color
  
  ## build plot, first open PNG device, then build histogram
  png(file=filename,width=w,height=h,units=u)
  hist(df$Global_active_power,xlab=xLabel,main=titleLabel,col=colcolor)
  
  ## clean up and close all devices (incase multiple were opened)
  rm(filename,h,u,w,titleLabel,colcolor,xLabel)
  for(i in 1:(dev.cur()-2)) {
    dev.off()
  }
}