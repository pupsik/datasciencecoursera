#Correlation function
corr <- function(directory, threshold=0) {
 dir <- paste(getwd(), directory, sep = "/" )
  filelist <- list.files(dir, pattern = ".csv", full.names=TRUE) 
 dataset <- data.frame()
 for(file in filelist) {
    tempdata <- read.csv(file, header = TRUE, ) 
    dataset <- rbind(dataset, tempdata)
    rm(tempdata)
  }
  dataset
  output <- as.numeric()
  subdata <- na.omit(dataset)
  for(i in 1:332) {
 sample <- na.omit(subset(subdata, subdata$ID == i))
 compcases <- sum(complete.cases(sample))
    if(compcases>threshold){
      nit <- sample[,"nitrate"]
      sulf <- sample[,"sulfate"]
      result <- cor(nit,sulf)
      output <- na.omit(append(output, result))
    }
  }
  output
}
  