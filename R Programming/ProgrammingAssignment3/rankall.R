# Write a function called rankall that takes two arguments: an outcome name (outcome) and a hospital ranking
#(num). The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
#containing the hospital in each state that has the ranking specified in num.
rankall <- function(outcome, num = "best") {
  outcomesofcare <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  #Convert relevant columns to numerical
  outcomesofcare[,c(11,17,23)] <- sapply(outcomesofcare[,c(11,17,23)], as.numeric)
  
  #Create unique list of states
  states <- unique(outcomesofcare$State)
  states <- as.list(sort(states))
  #Create unique list of outcomes
  outcomes <- as.list(c("heart attack", "heart failure", "pneumonia"))
  
  if(!(outcome %in% outcomes)) {
    stop("invalid outcome")
  }
  
  result <- data.frame("hospital" = character(0), "state" = character(0))
  
  if(outcome == "heart attack") {
    outcomesofcare <- outcomesofcare[complete.cases(outcomesofcare[,11]),]
    
    for(each in states) {
      index <- num
      hospranks <- outcomesofcare[outcomesofcare$State == each,]
      hospranks <- hospranks[order(hospranks[,11],hospranks[,2]),]
      
      if(index == "best") {
        index <- 1L
      }
      if(index == "worst") {
        index <- nrow(hospranks)
      }
      
      chosenhosp <- data.frame("hospital"=hospranks[index,2], "state"=each)
      result <- rbind(result, chosenhosp)
    }
  }
  
  if(outcome == "heart failure") {
    outcomesofcare <- outcomesofcare[complete.cases(outcomesofcare[,17]),]
    
      for(each in states) {
        index <- num
        hospranks <- outcomesofcare[outcomesofcare$State == each,]
        hospranks <- hospranks[order(hospranks[,17], hospranks[,2]),]
        
        if(index == "best") {
          index <- 1L
        }
        if(index == "worst") {
          index <- nrow(hospranks)
        }
        chosenhosp <- data.frame("hospital" = hospranks[index,2], "state" = each)
        result <- rbind(result, chosenhosp)
      }
  }
  
  if(outcome == "pneumonia") {
    outcomesofcare <- outcomesofcare[complete.cases(outcomesofcare[,23]),]
    
      for(each in states) {
        index <- num
        hospranks <- outcomesofcare[outcomesofcare$State == each,]
        hospranks <- hospranks[order(hospranks[,23], hospranks[,2]),]
       
        if(index == "best") {
          index <- 1L
        }
        
        if(index == "worst") {
          index <- nrow(hospranks)
        }
        
        chosenhosp <- data.frame("hospital" = hospranks[index,2], "state" = each)
        result <- rbind(result, chosenhosp)
      
      }
  }
  result
}