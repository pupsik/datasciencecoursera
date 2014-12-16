#Create pollutantmean function
pollutantmean <- function(directory, pollutant, id = 1:332) {
  dir <- paste(getwd(), directory, sep = "/" )
filelist <- list.files(dir, pattern = ".csv", full.names=TRUE)
dataset <- data.frame()

for(file in filelist) {
  tempdata <- read.csv(file, header=TRUE)
  dataset <- rbind(dataset, tempdata)
  rm(tempdata)
  }
subdata <- na.omit(subset(dataset, dataset$ID %in% c(id)))
output <- mean(subdata[,pollutant])
output
 }


  