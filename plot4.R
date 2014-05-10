plot4 <- function(file="household_power_consumption.txt") {
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
  
  ## common plot and data properties
  par(mfrow=c(2,2),cex.axis=0.7)                  # parameters to build by row
  filename <- "plot4.png"                         # define output filename
  w <- 480                                        # define width
  h <- 480                                        # define height
  u <- "px"                                       # define units
  
  ## Build specific plots
  # upper left corner - global act pwr vs datetime
  # define data
  xData <- df$datetime
  yData <- list(df$Global_active_power)
  # define colors
  lineColors <- c("black")
  # define labels
  xLabel <- ""                                    # define x axis label
  yLabel <- "Global Active Power"                 # define y axis label
  titleLabel <- ""                                # define title label
  # determine x & y range to help build plot
  xRange <- range(xData)
  yRange <- range(yData)
  ## build plot and add lines
  plot(xRange,yRange,type="n",xlab=xLabel,ylab=yLabel)
  for(i in 1:length(yData)) {
    lines(xData,yData[[i]],type="l",col=lineColors[i])
  }
  
  # upper right corner - voltage vs datetime
  # define data
  xData <- df$datetime
  yData <- list(df$Voltage)
  # define colors
  lineColors <- c("black")
  # define labels
  xLabel <- "datetime"                            # define x axis label
  yLabel <- "Voltage"                             # define y axis label
  titleLabel <- ""                                # define title label
  # determine x & y range to help build plot
  xRange <- range(xData)
  yRange <- range(yData)
  ## build plot and add lines
  plot(xRange,yRange,type="n",xlab=xLabel,ylab=yLabel)
  for(i in 1:length(yData)) {
    lines(xData,yData[[i]],type="l",col=lineColors[i])
  }
  
  # lower left corner - each energy sub metering vs datetime
  # define data and data labels (for legend)
  xData <- df$datetime
  yData <- list(df$Sub_metering_1,df$Sub_metering_2,df$Sub_metering_3)
  yDataLabels <- c(names(df)[7:9])
  # define colors
  lineColors <- c("black","red","blue")
  # define labels
  xLabel <- ""                                    # define x axis label
  yLabel <- "Energy sub metering"                 # define y axis label
  titleLabel <- ""                                # define title label
  # determine x & y range to help build plot
  xRange <- range(xData)
  yRange <- range(yData)
  ## build plot, add lines, and legend
  plot(xRange,yRange,type="n",xlab=xLabel,ylab=yLabel)
  for(i in 1:length(yData)) {
    lines(xData,yData[[i]],type="l",col=lineColors[i])
  }
  legend(x="topright",legend=yDataLabels,col=lineColors,lty=1,cex=0.8)
  
  # lower right corner - global reactive pwr vs datetime
  # define data
  xData <- df$datetime
  yData <- list(df$Global_reactive_power)
  # define colors
  lineColors <- c("black")
  # define labels
  xLabel <- "datetime"                            # define x axis label
  yLabel <- "Global_reactive_power"               # define y axis label
  titleLabel <- ""                                # define title label
  # determine x & y range to help build plot
  xRange <- range(xData)
  yRange <- range(yData)
  ## build plot, adjust axis so all x data labels show up, add lines, and legend
  plot(xRange,yRange,type="n",xlab=xLabel,ylab=yLabel)
  axis(side=2,at=seq(0,max(yRange),by=0.1))
  for(i in 1:length(yData)) {
    lines(xData,yData[[i]],type="l",col=lineColors[i])
  }
  
  ## because we built everything on the screen, copy into the PNG as promised
  dev.copy(png, file=filename,width=w,height=h,units=u)
  
  ## clean up and close all devices (incase multiple were opened)
  rm(filename,h,i,u,w,lineColors,titleLabel)
  rm(xData,xLabel,xRange,yData,yDataLabels,yLabel,yRange)
  for(i in 1:(dev.cur()-2)) {
    dev.off()
  }
}