
  
### ESA 2016 Time Series Workshop
setwd("/Users/MagdaGarbowski/Desktop/HARV/")

library(ggplot2)   # for plotting
library(lubridate) # part of tidyverse package
library(scales)    # for adjusting plot scales
library(gridExtra) # for arranging ggplots 

har.Met.daily<-read.csv("FisherTower-Met/hf001-06-daily-m.csv") 


### NEON data 
class(har.Met.daily)
head(har.Met.daily)
str(har.Met.daily)

# create plot of time series data
qplot(x=date, y=airt, data=har.Met.daily)
class(har.Met.daily$date)

#Convert date to date class with as.Date()
har.Met.daily$date<- as.Date(har.Met.daily$date)
class(har.Met.daily$date)
qplot(x=date, y=airt, data=har.Met.daily)

##TIME CLASSES

har.Met_15min<-read.csv(file="FisherTower-Met/hf001-10-15min-m.csv", stringsAsFactors = FALSE) # Can look up data with TAB key
str(har.Met_15min)
har.Met_15min$date<-as.Date(har.Met_15min$datetime) # creating column for date

#POSIXct  
har.Met_15min$dateCT<-as.POSIXct(har.Met_15min$datetime, format="%Y-%m-%dT%H:%M") ## POSixct - Need to tell it date format. Character T in the middle #Capital Y is four diget code... what would be the two digit code? 
str(har.Met_15min$dateCT)
# View(har.Met_15min)
?strptime  # If you want to specify how your date is showing up... all the abbreviations! 

# Add time zone  
har.Met_15min$datetime<-as.POSIXct(har.Met_15min$dateCT, format="%Y-%m-%dT%H:%M", tz="America/New_York")
# View(har.Met_15min)
head(har.Met_15min$datetime)


## Cleaning Data <- Gaps, missing data, etc.

head(har.Met_15min)
har.Met_15min_09.11<-subset(har.Met_15min, 
                            datetime>=as.POSIXct('2009-01-01 00:00', tz="America/New_York")& 
                              datetime<=as.POSIXct('2011-12-31 23:59', tz="America/New_York"))

qplot(x=datetime,y=airt, data=har.Met_15min_09.11)


### No Data Values

har.Met_15min_09.11[har.Met_15min_09.11$datetime==-9999]<-NA

#is.na allows to find any NA
sum(is.na(har.Met_15min_09.11$datetime))
sum(is.na(har.Met_15min_09.11$airt))

mean(is.na(har.Met_15min_09.11$datetime))
mean(is.na(har.Met_15min_09.11$airt))


##Time seriesplots with ggplot - PART 2

harMet.daily.09.11<-read.csv(file="FisherTower-Met/Met_HARV_Daily_2009_2011.csv")
class(harMet.daily.09.11$date)
harMet.daily.09.11$date<-as.Date(harMet.daily.09.11$date)

###In all ggplots: Specify dataframe, specify AES (aesthetics), specify geometry (boxplot, scatter, line, etc))
ggplot(harMet.daily.09.11, aes(date, airt))+geom_point(na.rm=TRUE, color="blue", size=.75, pch=9) #pch=plotting symbol 

AirTempDaily<-ggplot(harMet.daily.09.11, aes(date, airt))+geom_point(na.rm=TRUE, color="blue", size=.75, pch=9)+ggtitle("Air Temp Harvard Forest 2009 - 2011") + xlab("Date")+ylab("Air Temperature Degrees C")
AirTempDaily +  scale_x_date (labels=date_format("%b %Y"), breaks=date_breaks("1 year"))+ theme_bw()

###To change the number of ticks
###Add a trend line
AirTempDaily_Trend<-AirTempDaily+ stat_smooth(color="darkgreen")
AirTempDaily_Trend

###Plotting a subset with call "limits"
startTime<-as.Date("2011-01-01")
endTime<-as.Date("2011-12-31")
start.end<-c(startTime, endTime) ###To combine our objects 
AirTempDaily_2011<-ggplot(harMet.daily.09.11, aes(date, airt))+geom_point(na.rm=TRUE, color="blue", size=.75, pch=9)+ggtitle("Air Temp Harvard Forest 2009") + xlab("Date")+ylab("Air Temperature Degrees C")+
  scale_x_date (labels=date_format("%b %Y"), breaks=date_breaks("2 month"), limits=start.end)
AirTempDaily_2011 + theme_bw()

####Plot of precipitation 
head(harMet.daily.09.11$prec)
harMet.daily.09.11$prec
PrecipDaily<-ggplot(harMet.daily.09.11, aes(date, prec))+geom_point(na.rm=TRUE, color="blue", size=.75, pch=9) 

PrecipDaily<-PrecipDaily+ggtitle("Precipitation Harvard Forest 2009 - 2011") + xlab("Date")+ylab("Precipitation mm")
PrecipDaily +  scale_x_date (labels=date_format("%b %Y"), breaks=date_breaks("6 month"))+ theme_bw()

###As a line graph 
PrecipDaily2<-ggplot(harMet.daily.09.11, aes(date, prec))+geom_line(na.rm=TRUE, color="blue", size=.75) 

PrecipDaily2<-PrecipDaily2+ggtitle("Precipitation Harvard Forest 2009 - 2011") + xlab("Date")+ylab("Precipitation mm")
PrecipDaily2 +  scale_x_date (labels=date_format("%b %Y"), breaks=date_breaks("6 month"))+ theme_bw()

###As a bar graph 
PrecipDaily3<-ggplot(harMet.daily.09.11, aes(date, prec))+geom_bar(stat="identity", na.rm = TRUE) 

PrecipDaily3<-PrecipDaily3+ggtitle("Precipitation Harvard Forest 2009 - 2011") + xlab("Date")+ylab("Precipitation mm")

PrecipDaily3 +  scale_x_date (labels=date_format("%b %Y"), breaks=date_breaks("1 year"))+ theme_bw()

grid.arrange(AirTempDaily, PrecipDaily3, ncol=1)

### To plot one year at a time with facets
###Need to create column (categorical variable) called year

harMet.daily.09.11$year<-year(harMet.daily.09.11$date)
#View(harMet.daily.09.11)

##X scale stays the same 
AirTempDailyYear<-ggplot(harMet.daily.09.11, aes(date, airt))+geom_point(na.rm=TRUE, color="blue", size=.75, pch=9)+ggtitle("Air Temp Harvard Forest 2009 - 2011") + xlab("Date")+ylab("Air Temperature Degrees C")
AirTempDaily +  scale_x_date (labels=date_format("%b %Y"), breaks=date_breaks("1 year"))+ theme_bw()

AirTempDailyYear + facet_grid(.~year)

##Julien Day to set common scale on x axis 

AirTempDaily_JDay<-ggplot(harMet.daily.09.11, aes(jd, airt))+geom_point(na.rm=TRUE, color="blue", size=.75, pch=9)+ggtitle("Air Temp Harvard Forest 2009 - 2011") + xlab("Date")+ylab("Air Temperature Degrees C")
AirTempDaily_JDay 

AirTempDaily_JDay + theme_bw()+facet_grid(.~year) #.~ specifies whether plots are arranged horizontally or vertically
AirTempDaily_JDay + theme_bw()+facet_grid(year~.) 

### use add = TRUE to layer plots with same y scale on top of one another

### Too plot soil temp vs air temperature (SKIP)
AirSoilTemp <-ggplot(harMet.daily.09.11, aes(airt, s10t))+
  geom_point()+ggtitle("Air vs Soil Temp Harvard 2009-2011")+
  xlab("Air Temp (C)") + ylab ("Soil Temp (C)")
AirSoilTemp 

###Create month vector (Plot above by month)

harMet.daily.09.11$month<-month(harMet.daily.09.11$date)
str(harMet.daily.09.11$month)

AirSoilTemp_Month <-ggplot(harMet.daily.09.11, aes(airt, s10t))+
  geom_point()+ggtitle("Air vs Soil Temp Harvard 2009-2011")+
  xlab("Air Temp (C)") + ylab ("Soil Temp (C)")
AirSoilTemp_Month

AirSoilTemp_Month + theme_bw()+facet_wrap(~month, nc=3)

