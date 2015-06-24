#Set working directory
#setwd("C:/Users/hom42612/Desktop/Coursera/Exploratory Data Analysis/ExData_NEI_Data")
#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Total Emissions from PM2.5 in the United States from 1999 to 2008
Total <- aggregate(Emissions ~ year*Pollutant, data=NEI, sum)
#Change Units
Total <- cbind(Total[,1:2],
               "Emissions" = apply(data.frame(Total[,"Emissions"]), 1, function(x){x/1000000}))
#Use base plotting system to make a plot showing the total PM2.5 emission from all sources for each year
png("Plot1.png", units = "px", width = 480, height = 480)
barplot(Total$Emissions, Total$year, ylab = "Total Emissions (Millions)", xlab = "Year",
        names.arg = Total$year, main = "PM2.5 Total Emissions, United States, 1999-2008")
dev.off()