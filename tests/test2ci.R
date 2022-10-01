library(copent)
library(mnormt)
rho1 <- 0.5
rho2 <- 0.6
rho3 <- 0.5
sigma <- matrix(c(1,rho1,rho2,rho1,1,rho3,rho2,rho3,1),3,3)
x <- rmnorm(500,c(0,0,0),sigma)
ci1 <- ci(x[,1],x[,2],x[,3])
