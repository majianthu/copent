\name{ci}
\alias{ci}
\title{ Conditional independence test with copula entropy }
\description{

Testing conditional independence between (x,y) conditioned on z with copula entropy.

}
\usage{
ci(x,y,z,k=3,dt=2)
}
\arguments{
  \item{x}{ the data with 1 row.}
  \item{y}{ the data with 1 row.}
  \item{z}{ the data with 1 row.}
  \item{k}{ kth nearest neighbour, default = 3.}
  \item{dt}{ the type of distance between samples, 1 for Eclidean distance; 2 for Maximum distance.}
}
\details{

This program involves testing conditional independence between (\bold{x,y}) conditioned on \bold{z} with copula entropy nonparametrically. It was proposed in Ma (2019). 

The algorithm composes of two simple steps: estimating three copula entropy terms with \code{\link{copent}} and then calculate the test statistic.

The argument \bold{x,y,z} are for the data with 1 row and same length as samples from random variables. The argument \bold{k} and \bold{dt} is used in the kNN method for estimating entropy. \bold{k} is for the kth nearest neighbour (default = 3) and \bold{dt} is for the type of distance between samples which has currently two value options (1 for Eclidean distance, and 2(default) for Maximum distance).

}
\value{
The function returns the value of the test statistic of conditional independence.
}
\references{ 

Ma, Jian. Estimating Transfer Entropy via Copula Entropy. arXiv preprint arXiv:1910.04375 (2019).

}

\examples{

library(copent)
library(mnormt)
rho1 <- 0.5
rho2 <- 0.6
rho3 <- 0.5
sigma <- matrix(c(1,rho1,rho2,rho1,1,rho3,rho2,rho3,1),3,3)
x <- rmnorm(500,c(0,0,0),sigma)
ci1 <- ci(x[,1],x[,2],x[,3])

}
\keyword{conditional independence}
