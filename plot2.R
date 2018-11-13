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


##plot2
##Have total emissions from PM2.5 decreased in the Baltimore City,
##Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008?
##Use the base plotting system to make a plot answering this question.
BC<-subset(data, fips=="24510")
bc<-aggregate(Emissions~year, BC, sum)
png("plot2.png", width=480, height=480)
##making plot
barplot(height=(bc$Emissions)/10^6, names.arg=bc$year,
        main="Baltimore City pm2.5 Emissions",
        xlab="year", ylab="Emissions(10^6 tons)")
dev.off()
