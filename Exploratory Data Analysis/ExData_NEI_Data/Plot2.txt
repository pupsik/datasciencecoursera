#Set working directory
#setwd("C:/Users/hom42612/Desktop/Coursera/Exploratory Data Analysis/ExData_NEI_Data")
#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Total Emissions from PM2.5 in the United States from 1999 to 2008
Baltimore <- NEI[NEI$fips == "24510",]
Baltimore <- aggregate(Emissions ~ year*Pollutant, data=Baltimore, sum)
#Change Units
Baltimore <- cbind(Baltimore[,1:2],
               "Emissions" = apply(data.frame(Baltimore[,"Emissions"]), 1, function(x){x/1000}))
#Use base plotting system to make a plot showing the total PM2.5 emission from all sources for each year
png("Plot2.png", units = "px", width = 480, height = 480)
barplot(Baltimore$Emissions, Baltimore$year, ylab = "Total Emissions (Thousands)", xlab = "Year",
        names.arg = Baltimore$year, main = "PM2.5 Total Emissions, Baltimore City, 1999-2008")
dev.off()