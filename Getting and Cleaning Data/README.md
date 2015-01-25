#Getting and Cleaning Data: Week 3 Course Project#

## Introduction ##

This exercise is performed with the Human Activity Recognition Using Smartphones Dataset. The explanation of the dataset is included in the UCI_HAR_Dataset folder. This file will explain how all of the scripts work and how they are connected. 

## About The Code ##

The first step is to load all the packages that are used in the analysis. The codes relies on the functions from the following packages:

	dplyr
	tidyr
	stringr

The second step is to load all the training and test datasets as well as the files that contain dataset titles, activity types and subject id numbers. The code uses cbind and rbind functions to unite the data into a single data frame. 

In the third step, the code uses dplyr command 'select' to choose only the columns that contain 'mean' and 'std' values. 

In the fourth step, the code uses stringr commands to analyze name strings and make them more redible. For example, the code removes all special characters and spaces from the names. When the new column names are ready, they replace the old column names in the dataset. 

In the fifth step, traintype codes are replaced with the actual descriptive names. For example, number 5 is replaced with SITTING and so on. 

In the final step, the code extracts the tidy data set that contains means of all columns. 