#Set Working Directory (comment out when souring)
setwd("C:/Users/hom42612/Desktop/Coursera/Kennecter")
library(RCurl)
library(rjson)

#Read.table will read the file as text so that the leading zeros are preserved
STATECODES <- read.table("./Program Files/StateCodes.csv", header=TRUE, sep = ",",
                         colClasses = c("statecodes"="character",
                                        "statefull"="character",
                                        "stateabb"="character"))
statecodelist <- as.character(as.list(STATECODES$statecodes))

#Pull population figures by MSA from the Census

POPULATION <- data.frame("variable" = character(0),
                         "FIPS" = numeric(0),
                         "areaname" = character(0),
                         "state" = character(0),
                         "population" = character(0))

censusvarlist = c("P0010001") #total population

for (var in censusvarlist){ 
    for (state in statecodelist){
url <- paste("http://api.census.gov/data/2010/sf1?key=9a3374a10322c7799e3baa445c56da813a822b4c&get=",
                var,",NAME&for=metropolitan+statistical+area/micropolitan+statistical+area:*&in=state:",
                state, sep="")

    response <- getURL(url)

    if (response !="") {

    json <- fromJSON(response)

    for(i in 2:length(json)){
    temp <- json[[i]]
    tempframe <- data.frame("variable" = var,
                        "FIPS" = as.numeric(temp[4]),
                        "areaname" = temp[2],
                        "state" = temp[3],
                        "value" = temp[1])
    POPULATION <- rbind(POPULATION, tempframe)
    rm(temp)
    rm(tempframe)
    }
    }
}}

#Based on the population data, create an MSA List
FIPS <- POPULATION[,c("FIPS","name")]
#If an MSA spans across multiple states, FIPS will be duplicated to show different state portions
FIPS <- unique(FIPS)

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

#Pull Data from 2011 ACS5

#Read in the table with census variables we want to pull
CENSUSVARS <- read.table("./CensusVars.csv", header=TRUE, sep = ",",
                         colClasses = c("variable" = "character",
                                        "name" = "character"))

censusvarslist <- as.character(as.list(CENSUSVARS$Variable))


EDUATTAINMENT <- data.frame("variable" = character(0),
                         "FIPS" = numeric(0),
                         "areaname" = character(0),
                         "state" = character(0),
                         "value" = character(0))


for (state in statecodelist){
    for (var in censusvarslist){
        url <- paste("http://api.census.gov/data/2011/acs5?key=9a3374a10322c7799e3baa445c56da813a822b4c&get=",var,
                     ",NAME&for=metropolitan+statistical+area/micropolitan+statistical+area:*&in=state:",state, sep="")
        response <- getURL(url)
        json <- fromJSON(response)
   
        
    for(i in 2:length(json)){
        temp <- json[[i]]
        tempframe <- data.frame("variable" = var,
                                "FIPS" = as.numeric(temp[4]),
                                "areaname" = temp[2],
                                "state" = temp[3],
                                "value" = temp[1])
        
        EDUATTAINMENT <- rbind(EDUATTAINMENT, tempframe)
        rm(temp)
        rm(tempframe)
        
        }  
    }
}

