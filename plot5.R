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

##plot5
##How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(ggplot2)
BC<-subset(data, fips=="24510")
vehicled<-grepl("vehicle",BC$EI.Sector, ignore.case=TRUE)
subsetdata<-data[vehicled,]
bcvcl<-aggregate(Emissions~year,subsetdata,sum)
png("plot5.png", width=480, height=480)
g<-ggplot(bcvcl, aes(factor(year),Emissions))+
   geom_bar(stat="identity")+
   xlab("year")+ylab("Emissions")+
   ggtitle("total pm2.5 emissions of vehicle")
print(g)
dev.off()
