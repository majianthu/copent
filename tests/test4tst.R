library(copent)
library(mnormt)
rho <- 0.5
sigma <- matrix(c(1,rho,rho,1),2,2)
s0 <- rmnorm(600,c(0,0),sigma)
s1 <- rmnorm(500,c(5,5),sigma)
tst(s0,s1)

