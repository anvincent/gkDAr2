plot3 <- function(file="household_power_consumption.txt") {
  
  #### get data, prepare it for plotting
  ## read data
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
  yDataLabels <- c(names(df)[7:9])
  # color
  lineColors <- c("black","red","blue")
  
  ## define plot properties
  filename <- "plot3.png"
  w <- 480
  h <- 480
  u <- "px"
  xLabel <- ""
  yLabel <- "Energy sub metering"
  titleLabel <- ""
  xRange <- range(xData)
  yRange <- range(yData)
  
  ## build plot in png file
  png(file=filename,width=w,height=h,units=u)
  par(mfrow=c(2,2))
  #plot
  plot(xRange,yRange,type="n",xlab=xLabel,ylab=yLabel)
  #line(s)
  for(i in 1:length(yData)) {
    lines(xData,yData[[i]],type="l",col=lineColors[i])
  }
  #legend
  legend(x="topright",legend=yDataLabels,col=lineColors,lty=1)
  rm(filename,h,i,u,w,lineColors,titleLabel)
  rm(xData,xLabel,xRange,yData,yDataLabels,yLabel,yRange)
  dev.off()
}