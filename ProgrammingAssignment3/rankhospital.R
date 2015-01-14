#Write a function called rankhospital that takes three arguments: the 2-character abbreviated name of a
#state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
#The function returns a character vector with the name
#of the hospital that has the ranking specified by the num argument.
rankhospital <- function(state, outcome, num) {
  #Read outcome data
  outcomesofcare <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  #Convert relevant columns to numerical
  outcomesofcare[,c(11,17,23)] <- sapply(outcomesofcare[,c(11,17,23)], as.numeric)
  
  #Create unique list of states
  states <- unique(outcomesofcare$State)
  #Create unique list of outcomes
  outcomes <- as.list(c("heart attack", "heart failure", "pneumonia"))
  
  if(!(state %in% states)) {
    stop("invalid state")
  }
  
  if(!(outcome %in% outcomes)) {
    stop("invalid outcome")
  }
  
  #Subset the datasets only by the required state
  outcomesofcare <- outcomesofcare[outcomesofcare$State == state,]
  #Order by hospital name
  outcomesofcare <- outcomesofcare[order(outcomesofcare[,2]),]
  
  #Go through possible outcomes
  if(outcome == "heart attack") {
    #Remove all NAs from the relevant columns
    outcomesofcare <- outcomesofcare[complete.cases(outcomesofcare[,11]),]
    outcomesofcare <- outcomesofcare[order(outcomesofcare[,11]),]
  }
  
  else if(outcome == "heart failure") {
    outcomesofcare <- outcomesofcare[complete.cases(outcomesofcare[,17]),]
    outcomesofcare <- outcomesofcare[order(outcomesofcare[,17]),]
  }
  
  else if(outcome == "pneumonia") {
    outcomesofcare <- outcomesofcare[complete.cases(outcomesofcare[,23]),]
    outcomesofcare <- outcomesofcare[order(outcomesofcare[,23]),]
  }
  #Replace character strings with appropriate numbers
  if(num == "best") {
    num <- 1L
  }
  
  else if(num == "worst") {
    num <- nrow(outcomesofcare)
  }
  
  hospname <- outcomesofcare[num, "Hospital.Name"] 
  hospname
}