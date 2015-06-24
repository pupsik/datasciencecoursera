#Load Libraries
library(dplyr)
library(tidyr)
library(stringr)

#Set the working directory
setwd("C:/Users/hom42612/Desktop/Coursera/Getting and Cleaning Data/UCI_HAR_Dataset")
#Create Files for Training and Testing Datasets
trainfile <- ("./train/X_train.txt")
testfile <- ("./test/X_test.txt")
sbjtrainfile <- ("./train/subject_train.txt")
sbjtestfile <- ("./test/subject_test.txt")
ytrainfile <- ("./train/y_train.txt")
ytestfile <- ("./test/y_test.txt")
featuresfile <- ("./features.txt")
activity_labelsfile <- ('./activity_labels.txt')
#Read In Files
test <- read.table(testfile, sep = "")
train <- read.table(trainfile, sep = "")
sbjtrain <- read.table(sbjtrainfile, sep = "")
sbjtest <- read.table(sbjtestfile, sep = "")
ytrain <- read.table(ytrainfile, sep = "")
ytest <- read.table(ytestfile, sep="")
fullset <- cbind(rbind(test, train), rbind(sbjtest, sbjtrain), rbind(ytest, ytrain))
#Read in column names
features <- readLines(featuresfile)
activity_labels <- readLines(activity_labelsfile)

allnames <- c(features, "sbjnumber", "traintype")
rm(list=c("test", "train", "sbjtrain", "sbjtest", "ytrain", "ytest"))
#Append column names to the dataset
names(fullset) <- allnames
#Select only columns that contain MEAN and STD in their names
HARdata <- select(fullset, contains("mean"), contains("std"), sbjnumber, traintype)

#Extract the column names and make them more readible
colnames <- names(HARdata)
newcolnames <- as.character()
for (name in colnames) {
  colname <- gsub("-"," ", name)
  if(!is.na(extract_numeric(colname))) {
    colname <- gsub(extract_numeric(colname), "", colname)
  } else {colname <- colname}
  colname <- str_trim(gsub("\\(","", colname), "both")
  colname <- str_trim(gsub("\\)","", colname), "both")
  colname <- str_trim(gsub("\\,","", colname), "both")
  colname <- str_trim(gsub(" ","", colname), "both")
  newcolnames <- c(newcolnames, colname)
}
names(HARdata) <- newcolnames
#HARdata[,"traintype"] <- as.numeric(HARdata[,"traintype"])

#Use descriptive activity names to name the activities in the data set
for (j in 1:length(activity_labels)) {
  for (i in 1:nrow(HARdata)) {       
    if (is.numeric(as.numeric(HARdata[i, "traintype"]))) {
      if (HARdata[i, "traintype"] == as.numeric(word(activity_labels[j],1))) {
       #print(c(HARdata[i, "traintype"], activity_labels[5]))}
          HARdata[i, "traintype"] <- word(activity_labels[j],2)}
    }
  }
}

#Create an independent tidy data set with the average of each variable for each activity and each subject.
#HARgrouped <- group_by(HARdata, traintype, sbjnumber)

tidydata = select(aggregate(HARdata, by=list(activity = HARdata$traintype, subject=HARdata$sbjnumber), mean),-traintype, -sbjnumber)

#Write table to .txt
write.table(tidydata, "tidydata.txt", sep="\t", row.name=FALSE)









