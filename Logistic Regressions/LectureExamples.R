#Low Birth Weight Logistic Regression Example
#Import data set

BIRTHDATA <- read.table("http://www.statlab.uni-heidelberg.de/data/linmod/birthweight.data", 
                        sep="", header=TRUE)

#Code dummy variables

BIRTHDATA$other <- as.numeric(BIRTHDATA$race=="other")
BIRTHDATA$black <- as.numeric(BIRTHDATA$race=="black")

#Estimate GLM

eq_low <- glm(low~age+other+black+ftv+lwt, data=BIRTHDATA, family=binomial)
summary(eq_low)