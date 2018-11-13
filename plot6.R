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

##plot6
##Compare emissions from motor vehicle sources in Baltimore City
##with emissions from motor vehicle sources in Los Angeles County, 
##California (\color{red}{\verb|fips == "06037"|}fips=="06037"). 
##Which city has seen greater changes over time in motor vehicle emissions?
library(ggplot2)
city <- data[(data$fips=="24510"|data$fips=="06037"),  ]
vcl<-grepl("vehicle", city$EI.Sector, ignore.case=TRUE)
subsetdata<-city[vcl,]
pd<-aggregate(Emissions~year + fips,  subsetdata,  sum)
pd$fips[pd$fips=="24510"] <- "Baltimore, MD"
pd$fips[pd$fips=="06037"] <- "Los Angeles, CA"
png("plot6.png", width=480, height=480)
png("plot6.png", width=1040, height=480)
g <- ggplot(pd, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Emissions in Baltimore & California")
print(g)
dev.off()
