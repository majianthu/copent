\name{mvnt}
\alias{mvnt}
\title{ Multivariate normality test with copula entropy }
\description{

Estimating the statistic for testing multivariate normality based on copula entropy.

}
\usage{
mvnt(x,k=3,dt=2)
}
\arguments{
  \item{x}{ the data with each row as a sample of d-dimensional random variables}
  \item{k}{ kth nearest neighbour, default = 3}
  \item{dt}{ the type of distance between samples, 1 for Eclidean distance; 2 for Maximum distance}
}
\details{

This program involves estimating the statistic for testing multivariate normality based on copula entropy. It was proposed in Ma (2022). The test statistic is defined as the difference between the
copula entropies of unknown distribution and the Gaussian distribution with same covariance.

The argument \bold{x} is for the data with each row as a sample of d-dimensional random variables. The argument \bold{k} and \bold{dt} is used in the kNN method for estimating entropy. \bold{k} is for the kth nearest neighbour (default = 3) and \bold{dt} is for the type of distance between samples which has currently two value options (1 for Eclidean distance, and 2(default) for Maximum distance).

}
\value{
The function returns the statistic for testing multivariate normality of \bold{x}.
}
\references{ 

Ma, Jian. Multivariate Normality Test with Copula Entropy. arXiv preprint arXiv:2206.05956, 2022.

}

\examples{

library(mnormt)
rho <- 0.5
sigma <- matrix(c(1,rho,rho,1),2,2)
x <- rmnorm(1000,c(0,0),sigma)
mvnt(x)

}
\keyword{multivariate normality test}
