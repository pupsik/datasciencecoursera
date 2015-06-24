#Set working directory
#setwd("C:/Users/hom42612/Desktop/Coursera/Exploratory Data Analysis/ExData_NEI_Data")
library(ggplot2)
#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Total Emissions from PM2.5 in the United States from 1999 to 2008
SCC_Coal <- SCC[c(which(grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)), 
                  which(grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE))),]
SCC_List <- unique(SCC_Coal$SCC)
Total <- NEI[NEI$SCC %in% SCC_List,]
Total <- aggregate(Emissions ~ year + Pollutant, data=Total, sum)
Total <- cbind(Total[,1:2],
               "Emissions" = apply(data.frame(Total[,"Emissions"]), 1, function(x){x/1000000}))

png("Plot4.png", units="px", width = 480, height=480)
ggplot(Total, aes(factor(year), Emissions))+
  geom_bar(stat = "identity", fill="blue")+
  labs(x="Year", y="Emissions", 
       title = "Coal Combustion Related PM2.5 Emissions, United States, 1999-2008")
dev.off()