#Create Function
  complete <- function(directory, id = 1:332) {
  dir <- paste(getwd(), directory, sep = "/" )  
  filelist <- list.files(dir, pattern = ".csv", full.names=TRUE) 
  output <- data.frame()
  dataset <- data.frame()
  for(file in filelist) {
  tempdata <- read.csv(file, header = TRUE, ) 
  dataset <- rbind(dataset, tempdata)
  rm(tempdata)
  subdata <- na.omit(subset(dataset, dataset$ID %in% c(id)))
  }
  subdata
  for(i in id) {
  sample <- na.omit(subset(subdata, subdata$ID ==i)) 
  rows <- nrow(sample)
  nobs <- sum(complete.cases(sample))
  temp <- cbind(i, nobs)
  output <- rbind(output, temp)
  }
  output
  }