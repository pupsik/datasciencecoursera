library(datasets)
library(ggplot2)
rm(list=ls())
data(swiss)

eq1 <- summary(lm(Fertility ~ ., data=swiss))

#Why does the regression reverse sign? Example:

n <- 100; x2 <-1:n; 
x1 <- 0.01*x2 + runif(n, -0.1,0.1); 
y=-x1+x2+rnorm(n, sd=0.01)

summary(lm(y~x1))$coef
summary(lm(y~x1+x2))$coef

resx <- resid(lm(x1~x2))
resy <- resid(lm(y~x2))

#Once you factor the x2, the relationship bteween y and x1 shows up as actually negative
#*****************************************************************************************

#Dummy variables:
#beta1 is interpretted as the increase or decrease in the mean comparing those in the group to those not
#When the intercept is included, other coefficients are interpreted in relation to the intercept
#if there is no intercept, the coefficients on dummy variables are interpreted as their own means

#MANUAL EXAMPLE

data(InsectSprays)

fit <- lm(count~spray, data=InsectSprays)  #A is reference
#class(InsectSprays$spray)  is "factor"

bbmbc <- coef(fit)[2]-coef(fit)[3] #B-C
temp <- summary(fit) 

InsectSprays$predict <- predict(fit)
sigma <- sqrt(sum((InsectSprays$count-InsectSprays$predict)^2)/temp$df[2])
#(or sigma <- temp$sigma)
se <- temp$sigma * sqrt(temp$cov.unscaled[2,2]+temp$cov.unscaled[3,3]-2*temp$cov.unscaled[2,3])
t <- (coef(fit)[2]-coef(fit)[3])/se
p <- pt(-abs(t), df=fit$df)
out <- c(bbmbc, se, t, p)
names(out) <- c("B-C", "SE", "T", "P")
round(out,3)

#you can relevel the dummy reference
spray2 <- relevel(InsectSprays$spray, "C")

#*****************************************************************************************
#########  INTERACTIONS  ###########################
setwd("C:/Users/hom42612/Desktop/Coursera/Regressions/")
download.file("http://apps.who.int/gho/athena/data/GHO/WHOSIS_000008.csv?profile=text&filter=COUNTRY:*;SEX:*",
              destfile = "C:/Users/hom42612/Desktop/Coursera/Regressions/hunger.csv")

hunger <- read.csv("hunger.csv")
hunger <- hunger[hunger$Sex!="Both sexes",]
lm1 <- lm(hunger$Numeric ~ hunger$Year)
plot(hunger$Year, hunger$Numeric, pch=19, col="blue")
lines(hunger$Year, lm1$fitted, lwd=3, col="darkgrey")

#Is there a difference in hunger by gender?
plot(hunger$Year, hunger$Numeric, pch=19)
points(hunger$Year, hunger$Numeric, pch=19, col=((hunger$Sex == "Male")*1+1))

#We will fit two regression lines: one for MAKE, another for FEMALE
lmM <- lm(hunger$Numeric[hunger$Sex=="Male"]~hunger$Year[hunger$Sex=="Male"])
lmF <- lm(hunger$Numeric[hunger$Sex=="Female"]~hunger$Year[hunger$Sex=="Female"])

plot(hunger$Year, hunger$Numeric, pch=19)
points(hunger$Year, hunger$Numeric, pch = 19, col=((hunger$Sex=="Male")*1+1))
lines(hunger$Year[hunger$Sex=="Male"], lmM$fitted, col="black", lwd=3)
lines(hunger$Year[hunger$Sex=="Female"], lmF$fitted, col="red", lwd=3)

#Include DUMMY VARIABLE instead
#TWO LINES THE SAME SLOPE
lmBoth <- lm(hunger$Numeric ~ hunger$Year+hunger$Sex)
plot(hunger$Year, hunger$Numeric, pch=19)
points(hunger$Year, hunger$Numeric, pch=19, col=((hunger$Sex=="Male")*1+1))
abline(c(lmBoth$coeff[1], lmBoth$coeff[2]),col="red", lwd=3)
abline(c(lmBoth$coeff[1]+lmBoth$coeff[3], lmBoth$coeff[2]), col="black", lwd=3)

#Result: we have two lines that have difference intercepts depending on gender, but have the same slope
#This is expected because the YEAR does ont ingeract with GENDER

#TWO LINES DIFFERENT SLOPES
lmBoth <- lm(hunger$Numeric ~ hunger$Year+hunger$Sex+hunger$Sex*hunger$Year)
plot(hunger$Year, hunger$Numeric, pch=19)
points(hunger$Year, hunger$Numeric, pch=19, col=((hunger$Sex=="Male")*1+1))
abline(c(lmBoth$coeff[1], lmBoth$coeff[2]),col="red", lwd=3)
abline(c(lmBoth$coeff[1]+lmBoth$coeff[3], lmBoth$coeff[2]+lmBoth$coeff[4]), col="black", lwd=3)

#Assume a regression with an interaction term: 
# beta3 is the CHANGE in the EXPECTED CHANGE in Y per unit change in X1, per unit change in X2
# or, the change in the slope relatinvg X1 and Y per unit change in X2

