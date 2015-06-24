#Set working directory
#setwd("C:/Users/hom42612/Desktop/Coursera/Exploratory Data Analysis/ExData_NEI_Data")
library(ggplot2)
#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Total Emissions from PM2.5 in the United States from 1999 to 2008
SCC_MotVeh <- SCC[which(grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)),]
SCC_List <- unique(SCC_MotVeh$SCC)
Baltimore <- NEI[NEI$fips == "24510",]
Baltimore <- Baltimore[Baltimore$SCC %in% SCC_List,]
Baltimore <- aggregate(Emissions ~ year + Pollutant, data=Baltimore, sum)

png("Plot5.png", units="px", width = 480, height=480)
ggplot(Baltimore, aes(factor(year), Emissions))+
  geom_bar(stat = "identity", fill="blue")+
  labs(x="Year", y="Emissions", 
       title = "Motor Vehicle PM2.5 Emissions in Baltimore City, 1999-2008")
dev.off()
