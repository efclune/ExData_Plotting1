#######
## Data Exploration - First Project - Ed Clune
#######
## Simple function to read in data file, convert data to useful form,
## generate a graph and save it to a png file.  One of several functions, all
## using the same data and differing in the function name and the graph that
## is generated and saved
##
## Note: Because to the amount of time the function takes, some Print statements
## were included to let the user know that the function is progressing
#######

Plot1<-function()
{
    print("Function Start")     ## Read in data file
    data<-read.table("household_power_consumption.txt",header=TRUE,sep=";")
    print("File read in")
    
    ## combine Date and Time variables and make a true DateTime variable
    ## Once the new DateTime variable is created, Date and Time are removed
    data$Date<-as.character(data$Date)
    data$Time<-as.character(data$Time)
    data$DateTime<-paste(data$Date, data$Time)
    data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
    data$Date<-NULL
    data$Time<-NULL
    print("Date/Time Converted")
    
    ## At this point, as an optimization, the dataset is reduced to the
    ## required dates for the project.  This includes removing data with
    ## no valid DateTime.  The end resulting data contains 2880 records,
    ## one for every minute of the 2 day period (2*60*24=2880)
    data<-data[data$DateTime>="2007-02-01" & data$DateTime<"2007-02-03",]
    data<-data[!is.na(data$DateTime),]
    print("Data Reduced to Specified Dates")
    
    ## The rest of the data is converted to numeric
    data$Global_active_power<-as.character(data$Global_active_power)
    data$Global_active_power<-as.numeric(data$Global_active_power)
    data$Global_reactive_power<-as.character(data$Global_reactive_power)
    data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
    data$Voltage<-as.character(data$Voltage)
    data$Voltage<-as.numeric(data$Voltage)
    data$Global_intensity<-as.character(data$Global_intensity)
    data$Global_intensity<-as.numeric(data$Global_intensity)
    data$Sub_metering_1<-as.character(data$Sub_metering_1)
    data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
    data$Sub_metering_2<-as.character(data$Sub_metering_2)
    data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
    data$Sub_metering_3<-as.character(data$Sub_metering_3)
    data$Sub_metering_3<-as.numeric(data$Sub_metering_3)

    print("Other Parameters Converted")

    png("Plot1.png")
    
    ## Histogram of Global_active_Power, with adjustments to the graph
    hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", 
         main="Global Active Power", xlim=c(0,6), ylim=(c(0,1200)))
    
    dev.off()
    
    print("Function End")
}
