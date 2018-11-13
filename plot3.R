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

##plot3
##Of the four types of sources indicated by the \color{red}{\verb|type|}
##type (point, nonpoint, onroad, nonroad) variable,which of these four sources
##have seen decreases in emissions from 1999–2008 for Baltimore City? 
##Which have seen increases in emissions from 1999–2008? 
##Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)
BC<-subset(data, fips=="24510")
bc<-aggregate(Emissions~year+type, BC, sum)
png("plot3.png", width=480, height=480)
g<-ggplot(bc,aes(x=year, y=Emissions, color=type))+
   geom_point(alpha=0.4)+
   geom_smooth(alpha=0.3, method="loess")+
   ggtitle("pm2.5 emissions by different type in Baltimore")
print(g)
dev.off()
