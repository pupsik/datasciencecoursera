library(UsingR)
data(diamond)

diamond$e <- resid(lm(price~carat, data=diamond))

g = ggplot(diamond, aes(x = carat, y=e))+
    xlab("Mass(carats)")+
    ylab("Residual Price (SIN $)")+
    geom_hline(yintercept = 0, size=2)+
    geom_point(size=7, colour="black", alpha = 0.5)+
    geom_point(size=5, colour = "blue", alpha = 0.2)
g

##### We will plot the residuals as a variations from the mean and resids are a 
#variation from the regression line

e = c(resid(lm(price~1, data = diamond)),
      resid(lm(price ~ carat, data = diamond)))

fit = factor(c(rep("Its", nrow(diamond)),
               rep("Itc, slope", nrow(diamond))))

g = ggplot(data.frame(e =e, fit=fit), aes(y=e, x=fit, fill=fit))+
    geom_dotplot(binaxis = "y", size = 2, stackdir = "center", binwidth=20)+
    xlab("Fitting Approach")+
    ylab("Residual Price")
g        

###################################################################
library(UsingR); data(diamond)
rm(list=ls())
y <- diamond$price
x <- diamond$carat
n <- length(y)

beta1 <- cor(x,y)*sd(y)/sd(x)
beta0 <- mean(y) - beta1*mean(x)
e <- y - beta0 - beta1*x
sigma <- sqrt(sum(e^2)/(n-2))
ssx <- sum((x-mean(x))^2) #variation in x
seBeta0 <- (1/n+mean(x)^2/ssx)^0.5*sigma
seBeta1 <- sigma/sqrt(ssx)

tBeta0 <- beta0/seBeta0; tBeta1 <- beta1/seBeta1
pBeta0 <- 2*pt(abs(tBeta0), df=n-2, lower.tail=FALSE)
pBeta1 <- 2*pt(abs(tBeta1), df=n-2, lower.tail=FALSE)

coefTable <- rbind(c(beta0, seBeta0, tBeta0, pBeta0), c(beta1, seBeta1, tBeta1, pBeta1))
colnames(coefTable) <- c("Estimate", "Std. Error", "t value", "P(>|t|)")
rownames(coefTable) <- c("Intercept", "x")

#alternatively
fit <- lm(y~x)
sumCoef <- summary(fit)$coefficients

#Establish confidence intervals
sumCoef[1,1] + c(-1,1)*qt(0.975, df=fit$df)*sumCoef[1,2]   #sumCoef[1,2] is standard error
sumCoef[2,1] + c(-1,1)*qt(0.975, df=fit$df)*sumCoef[2,2]

##Confidence Intervals for Predictions
library(ggplot2)
newx = data.frame(x=seq(min(x), max(x), length=100))
p1 = data.frame(predict(fit, newdata = newx, interval = ("confidence")))
p2 = data.frame(predict(fit, newdata=newx, interval = ("prediction")))
p1$interval = "confidence"
p2$interval = "prediction"

p1$x = newx$x
p2$x = newx$x

dat = rbind(p1,p2)
names(dat)[1] = "y"

g = ggplot(dat, aes(x=x, y=y))+
    geom_ribbon(aes(ymin = lwr, ymax = upr, fill=interval), alpha = 0.2)+
    geom_line()+
    geom_point(data=data.frame(x=x,y=y), aes(x=x,y=y), size=4)
g

###############################
#Multivariate regression
n=100; x=rnorm(n); x2 = rnorm(n); x3=rnorm(n)

y = 1+x+x2+x3+rnorm(n, sd=0.1)

ey = resid(lm(y~x2+x3))
ex = resid(lm(x~x2+x3))

beta = sum(ey*ex)/sum(ex^2)
betareg = coef(lm(ey~ex-1))
coef(lm(y~x+x2+x3))




