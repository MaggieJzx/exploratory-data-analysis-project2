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

##plot4
##Across the United States, how have emissions from
##coal combustion-related sources changed from 1999–2008?
library(ggplot2)
##select all data related to "coal"
coalmatches<-grepl("coal",data$Short.Name, ignore.case=TRUE)
subsetdata<-data[coalmatches,]
##making plot
png("plot4.png", width=480, height=480)
cd<-aggregate(Emissions~year,subsetdata,sum)
g<-ggplot(cd, aes(x=year, y=Emissions))+
   geom_point(alpha=0.4)+
   geom_smooth(alpha=0.3, size=1)+
   ggtitle("total pm2.5 coal combustion emissions")
print(g)
dev.off()
