#Write a function called best that take two arguments: the 2-character abbreviated name of a state and an
#outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
#with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
#in that state.
best <- function(state, outcome) {
  #Read outcome data
  outcomesofcare <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  #Convert columns to numeric when needed
  outcomesofcare[,11] <- as.numeric(outcomesofcare[,11]) #heart attack
  outcomesofcare[,17] <- as.numeric(outcomesofcare[,17]) #heart failure
  outcomesofcare[,23] <- as.numeric(outcomesofcare[,23]) #pneumonia
  #Sort the dataset by hospital name - this will mean that hospital are also sorted within each state
  outcomesofcare <- outcomesofcare[order(outcomesofcare[,2]),]
  
  #Create strings
  
  
  states <- unique(outcomesofcare$State)
  outcomes <- as.list(c("heart attack", "heart failure", "pneumonia"))
  
  if(!(state %in% states)) {
    stop("invalid state")
    
  }
  
  if(!(outcome %in% outcomes)) {
    stop("invalid outcome")
    
  }
  
  #Subset by state
  outcomesofcare <- outcomesofcare[outcomesofcare$State == state,]
  
  if(outcome == "heart attack") {
    result <- outcomesofcare[which.min(outcomesofcare[,11]), "Hospital.Name"]
  }
  else if(outcome == "heart failure") {
    result <- outcomesofcare[which.min(outcomesofcare[,17]), "Hospital.Name"]
  }
  
  else if(outcome == "pneumonia") {
    result <- outcomesofcare[which.min(outcomesofcare[,23]), "Hospital.Name"]
  }
  result
}