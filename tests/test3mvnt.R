library(copent)
library(mnormt)
rho <- 0.5
sigma <- matrix(c(1,rho,rho,1),2,2)
x <- rmnorm(1000,c(0,0),sigma)
mvnt(x)

