#Set working directory
#setwd("C:/Users/hom42612/Desktop/Coursera/Exploratory Data Analysis/ExData_NEI_Data")
library(ggplot2)
#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Total Emissions from PM2.5 in the United States from 1999 to 2008
Baltimore <- NEI[NEI$fips == "24510",]
Baltimore <- aggregate(Emissions ~ year*type + Pollutant, data=Baltimore, sum)
png("Plot3.png", units="px", width = 480, height=480)
#Use ggplot2 to plot by type
Plot3 <- ggplot(Baltimore, aes(x=factor(year), y=Emissions, fill=type))+
  geom_bar(stat = "identity")+
  facet_grid(.~type)+
  guides(fill=FALSE)+
  theme(axis.text.x=element_text(angle=-90))+
  labs(x = "Year", y= "Emissions", title = "Total PM2.5 Emissions by Type, United States, 1999-2008")
print(Plot3)
dev.off()