#Set working directory
setwd("C:/Users/hom42612/Desktop/Coursera/Kennecter")
#Establish BLS mnemonic format. You can get help here:
#http://www.bls.gov/help/hlpforma.htm
#You must register with the BLS API and get your key#
#You can make up to 500 data requests per day with the key with up to 50 series per request
#Set libraries
library(rjson)
library(blsAPI)
library(jsonlite)
library(dplyr)
library(reshape)

#Read in .csv file with the mnemonics you need to pull. Your file should have a column named "Mnemonic" to run.
SeriesFrame <- read.csv("./BLSData.csv")
SeriesList <- as.list(SeriesFrame[,"Mnemonic"])

#Create blank data frame that will have your final results. Change table names or column names as needed. 
MeanWage <- data.frame("ID" = character(0), 
                        "Year" = character(0), 
                        "Period"= character(0), 
                        "PeriodNAme" = character(0),
                        "Mean_Wage" = numeric(0))

#We can only request 50 series at a time from BLS, so must break inquiry into sets of 50 series
k <- 1L
for(i in c(seq(50, nrow(SeriesFrame), by=50),nrow(SeriesFrame))){
templist <- as.list(SeriesFrame[k:i,"Mnemonic"])  
assign(paste("SeriesList", i, sep = "_"), as.list(SeriesFrame[k:i,"Mnemonic"]))
#Paste your own 'key'  
fetchlist <- list('seriesid'=templist, 'registrationKey' = 'a8338f75033c4cf78613acb6ca3fc026')
response <- blsAPI(fetchlist,2)
myjson <- fromJSON(response)
#Create blank data frame to store temp results
TempTable <- data.frame("ID" = character(0), 
                       "Year" = character(0), 
                       "Period"= character(0), 
                       "PeriodNAme" = character(0),
                       "Mean_Wage" = numeric(0))

for(j in 1:length(templist)){
#Verify json structure prior to parsing, though all BLS series should have the same format
temp <- myjson$Results[[1]][[j]]
datatable <- data.frame(ID = sapply(temp$seriesID, "["),
                        Year = sapply(temp$data, "[[","year"), 
                        Period = sapply(temp$data, "[[","period"),
                        PeriodName=sapply(temp$data,"[[","periodName"),
                        Mean_Wage = as.numeric(sapply(temp$data,"[[", "value")),
                        stringsAsFactors=FALSE, row.names=NULL)

TempTable <- rbind(TempTable, datatable)
}
MeanWage <- rbind(MeanWage, TempTable)
k <- k+50 
}
#Select/Reshape data if you need
MeanWageExp <- select(MeanWage, ID, Year, Period, Mean_Wage)
MeanWageExp <- reshape(MeanWageExp, 
                       idvar = c("ID", "Year"), timevar = c("Period"),direction = "wide")
MeanWageExp <- reshape(MeanWageExp, 
                       idvar = c("ID"), timevar = c("Year"),direction = "wide")

write.table(MeanWageExp, "./MeanWage.csv", sep = ",", col.names=TRUE, row.names=FALSE)








