#SIMULATION #1
rm(list=ls())

n <- 100
x <- c(10, rnorm(n))
y <- c(10, c(rnorm(n)))
plot(x,y,frame=FALSE, cex=2, pch=21, bg="lightblue", col = "black")
abline(lm(y~x))

#Point c(10,10) has created a strong regression relationship where there shouldn't be one
fit <- lm(y~x)
round(dfbetas(fit)[1:10,2],3) #how coefficients change by excluding one point


#SIMULATION #2
dat <- read.table('http://www4.stat.ncsu.edu/~stefanski/NSF_Supported/Hidden_Images/orly_owl_files/orly_owl_Lin_4p_5_flat.txt', header = FALSE)
pairs(dat)
summary(lm(V1 ~ . -1, data = dat))$coef
fit <- lm(V1 ~ . - 1, data = dat); 
plot(predict(fit), resid(fit), pch = '.')