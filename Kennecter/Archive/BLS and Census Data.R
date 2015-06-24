#Pull the data from the BLS
#setwd("C:/Users/hom42612/Desktop/Coursera/Kennecter")
library(blsAPI)
library(rjson)

#Local Area Unemployment Statistics
#http://download.bls.gov/pub/time.series/la/la.area 
#http://www.bls.gov/help/hlpforma.htm#OE

#measure_code    measure_text
#03	unemployment rate
#04	unemployment
#05	employment
#06	labor force

#MT2571650000000    Boston-Cambridge-Nashua, MA-NH Metropolitan
#MT3635620000000    New York-Newark-Jersey City, NY-NJ-PA Metropolitan Statistical Area
#MT0641860000000    San Francisco-Oakland-Hayward, CA Metropolitan Statistical Area

input <- read.csv("./BLSData.csv", colClasses = "character")
inputlist <- as.list(input[1:nrow(input),])

#Create blank data frame that will have your final results. Change table names or column names as needed. 
output <- data.frame("ID" = character(0), 
                       "Year" = character(0), 
                       "Period"= character(0), 
                       "PeriodNAme" = character(0),
                       "Mean_Wage" = numeric(0))

#serieslist = as.list(c('LAUCN040010000000005','LAUCN040010000000006'))

query <- list('seriesid'=inputlist,
                   'startyear'=1994,
                   'endyear'=2014,
              'registrationKey'='a8338f75033c4cf78613acb6ca3fc026')

response <- blsAPI(query,2)
json <- fromJSON(response)

for(j in 1:length(inputlist)){
#Parsing JSON String
temp <- json$Results[[1]][[j]]
tempoutput <- data.frame(seriesID=sapply(temp$seriesID,"["),
                     year=sapply(temp$data,"[[", "year"),
                     period=sapply(temp$data,"[[", "period"),
                     periodName=sapply(temp$data,"[[","periodName"),
                     value=as.numeric(sapply(temp$data,"[[","value")),
                     stringsAsFactors=FALSE,row.names=NULL)
output <- rbind(tempoutput,output)
}

output$year <- as.numeric(output$year)
output <- output[order(output$year,decreasing=TRUE),]
output <- output[output$year == 2013,]

#Pulling data from America 
#http://cran.r-project.org/web/packages/acs/acs.pdf
library(acs)
#Load the API Key
api.key.install(key="9a3374a10322c7799e3baa445c56da813a822b4c")
#Create GEO Object
msas <- geo.make(state=c("MA","NY"), msa="*")
acsdata <- acs.fetch(endyear=2011, span=5, msas, table.number="B23006")
acsframe <- as.data.frame(estimate(acsdata))
acsframe <- cbind(Row.Names = rownames(acsframe), acsframe)
#Select the Variables We Need
#Mnemonics codes:
#B23006_001: Total Population
#B23006_003+B23006_010+B23006_017+B23006_024: Total Labor Force
#B23006_007+B23006_014+B23006_021+ B23006_028: Total Unemployed
#B23006_021: Unemployed with Some College or Associate's Degree
#B23006_028: Unemployment with Bachelor's Degree or Higher

#This will give us the share the educated unemployed make up relative to all unemployed by MSA
acsframe <- mutate(acsframe, BSunemp = B23006_028/(B23006_007+B23006_014+B23006_021+ B23006_028))
BSRU_BOS <- acsframe[acsframe$Row.Names==
                         "Boston-Cambridge-Quincy, MA-NH Metro Area (part); Massachusetts","BSunemp"]
BSRU_NYC <- acsframe[acsframe$Row.Names == 
                         "New York-Northern New Jersey-Long Island, NY-NJ-PA Metro Area (part); New York", "BSunemp"]

BSRU_BOS_FR <- output[output$seriesID == "LAUMT257165000000004",]
BSRU_BOS_FR <- mutate(BSRU_BOS_FR, BSRU_BOS_N = value*BSRU_BOS)

