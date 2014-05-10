plot3 <- function(file="household_power_consumption.txt") {
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
  
  ## data properties
  # data
  xData <- df$datetime
  yData <- list(df$Sub_metering_1,df$Sub_metering_2,df$Sub_metering_3)
  yDataLabels <- c(names(df)[7:9])               # define data labels from data
  lineColors <- c("black","red","blue")          # define line colors (in order)
  
  ## define plot properties
  par()                                          # reset parameters
  filename <- "plot3.png"                        # define output filename
  w <- 480                                       # define width
  h <- 480                                       # define height
  u <- "px"                                      # define units
  xLabel <- ""                                   # define x axis label
  yLabel <- "Energy sub metering"                # define y axis label
  titleLabel <- ""                               # define title label
  # determine x & y range to help build plot
  xRange <- range(xData)
  yRange <- range(yData)
  
  ## build plot by first open PNG device, then build plot, add lines, add legend
  png(file=filename,width=w,height=h,units=u)
  #plot
  plot(xRange,yRange,type="n",xlab=xLabel,ylab=yLabel)
  #line(s)
  for(i in 1:length(yData)) {
    lines(xData,yData[[i]],type="l",col=lineColors[i])
  }
  #legend
  legend(x="topright",legend=yDataLabels,col=lineColors,lty=1)
  
  ## clean up and close all devices (incase multiple were opened)
  rm(filename,h,i,u,w,lineColors,titleLabel)
  rm(xData,xLabel,xRange,yData,yDataLabels,yLabel,yRange)
  for(i in 1:(dev.cur()-2)) {
    dev.off()
  }
}