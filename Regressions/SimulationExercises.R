#Exercise 1:
rm(list=ls())
n<- 100
t<- rep(c(0,1), c(n/2,n/2))
x <- c(runif(n/2), runif(n/2))
beta0 <- 0
beta1 <- 2
tau <- 1 #dummy variable
sigma <- 0.2

y <- beta0+x*beta1+t*tau+rnorm(n, sd=sigma)

plot(x,y, type="n", frame="FALSE") #type=n creates a plot frame without actually outputting the plot
#this allows to later color the points in different colors
abline(lm(y~x), lwd=2)
abline(h=mean(y[1:(n/2)]),lwd=3) #mean of the first 1/2 of observations
abline(h=mean(y[(n/2+1):n]), lwd=3) #mean of the second 1/2 of observations
fit <- lm(y~x+t)
abline(coef(fit)[1], coef(fit)[2], lwd=3)
abline(coef(fit)[1]+coef(fit)[3], coef(fit)[2], lwd=3)
points(x[1:(n/2)],y[1:(n/2)], pch=21, col="black", bg="lightblue", cex=2)
points(x[(n/2+1):n], y[(n/2+1):n], pch=21,col="black", bg="salmon", cex=2)

#Interaction - when the value of Y depends on what particular value of X you are at - meaning
#that the slope of the relationship changes as X changes

#SIMULATION 2
n <- 100; t <- rep(c(0, 1), c(n/2, n/2)); x <- c(runif(n/2), 1.5 + runif(n/2)); 
beta0 <- 0; beta1 <- 2; tau <- 0; sigma <- .2
y <- beta0 + x * beta1 + t * tau + rnorm(n, sd = sigma)
plot(x, y, type = "n", frame = FALSE)
abline(lm(y ~ x), lwd = 2)
abline(h = mean(y[1 : (n/2)]), lwd = 3)
abline(h = mean(y[(n/2 + 1) : n]), lwd = 3)
fit <- lm(y ~ x + t)
abline(coef(fit)[1], coef(fit)[2], lwd = 3)
abline(coef(fit)[1] + coef(fit)[3], coef(fit)[2], lwd = 3)
points(x[1 : (n/2)], y[1 : (n/2)], pch = 21, col = "black", bg = "lightblue", cex = 2)
points(x[(n/2 + 1) : n], y[(n/2 + 1) : n], pch = 21, col = "black", bg = "salmon", cex = 2)

#SIMULATION 3
n <- 100; t <- rep(c(0, 1), c(n/2, n/2)); x <- c(runif(n/2), .9 + runif(n/2)); 
beta0 <- 0; beta1 <- 2; tau <- -1; sigma <- .2
y <- beta0 + x * beta1 + t * tau + rnorm(n, sd = sigma)
plot(x, y, type = "n", frame = FALSE)
abline(lm(y ~ x), lwd = 2)
abline(h = mean(y[1 : (n/2)]), lwd = 3)
abline(h = mean(y[(n/2 + 1) : n]), lwd = 3)
fit <- lm(y ~ x + t)
abline(coef(fit)[1], coef(fit)[2], lwd = 3)
abline(coef(fit)[1] + coef(fit)[3], coef(fit)[2], lwd = 3)
points(x[1 : (n/2)], y[1 : (n/2)], pch = 21, col = "black", bg = "lightblue", cex = 2)
points(x[(n/2 + 1) : n], y[(n/2 + 1) : n], pch = 21, col = "black", bg = "salmon", cex = 2)

#******************************************************************************************






