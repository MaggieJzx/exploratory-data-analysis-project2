##load the data from website
setwd("F:/R-3.5.1/coursera")
if(!file.exists("data")){dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="./data/pm25.zip")
unzip("./data/pm25.zip", exdir="./data")

##read data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC0 <- readRDS("./data/Source_Classification_Code.rds")
##merge two datasets
SCC<-subset(SCC0, select=c(SCC, Short.Name,EI.Sector))
data<-merge(NEI, SCC, by="SCC")


##plot1 
##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
##Using the base plotting system, make a plot showing the total PM2.5 emission from
##all sources for each of the years 1999, 2002, 2005, and 2018.
td<-aggregate(Emissions~year, data, sum)
##making the plot
png("plot1.png", width=480, height=480)
barplot(height=(td$Emissions)/10^6,names.arg=td$year, 
        main="total pm2.5 emissions from all sources",
          xlab="year",
          ylab="pm2.5 emissions(10^6 tons)")
dev.off()
