\name{entknn}
\alias{entknn}
\title{ Estimating entropy from data with kNN method }
\description{

Estimating entropy from data with kNN method.

}
\usage{
entknn(x,k=3,dt=2)
}
\arguments{
  \item{x}{ the data with each row as a sample.}
  \item{k}{ kth nearest neighbour, default = 3.}
  \item{dt}{ the type of distance between samples, = 1 for Eclidean distance; other for Maximum distance.}
}
\details{

This program involves estimating entropy from data by kNN method. It was proposed in Kraskov et al (2004). The algorithm is the second step of estimating copula entropy \code{\link{copent}}. 

The argument \bold{x} is for the data with each row as a sample from random variables. The argument \bold{k} and \bold{dt} is used in the kNN method for estimating entropy. \bold{k} is for the kth nearest neighbour (default = 3) and \bold{dt} is for the type of distance between samples which has currently two value options (1 for Eclidean distance, and 2(default) for Maximum distance).

}
\value{
The function returns the estimated entropy value of data \bold{x}.
}
\references{ 

Kraskov, A., St\"ogbauer, H., & Grassberger, P. (2004). Estimating Mutual Information. \emph{Physical Review E}, \bold{69}(6), 66138.

}

\examples{

library(mnormt)
rho <- 0.5
sigma <- matrix(c(1,rho,rho,1),2,2)
x <- rmnorm(500,c(0,0),sigma)
xent1 <- entknn(x)

}
\keyword{entropy; kNN}
