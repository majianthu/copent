\name{tst}
\alias{tst}
\title{ Two-sample test with copula entropy }
\description{

Estimating the statistic for two-sample test based on copula entropy.

}
\usage{
tst(s0,s1,n=12,k=3,dt=2)
}
\arguments{
  \item{s0,s1}{ two samples with each row as a sample for d-dimensional random variables.}
  \item{n}{repeat time of estimation to reduce estimation bias.}
  \item{k}{ kth nearest neighbour, default = 3.}
  \item{dt}{ the type of distance between samples, 1 for Eclidean distance; 2 for Maximum distance.}
}
\details{

This program involves estimating the statistic for non-parametric multivariate two-sample test based on copula entropy. It was proposed in Ma (2023). The test statistic is defined as the difference between the copula entropies of the null hypothesis and the alternative of two-sample test.

The argument \bold{s0,s1} is for the two samples with each row as a sample from d-dimensional random variables. The argument \bold{n} is the repeat time of estimation for reducing the estimation bias (dafault = 12). The argument \bold{k} and \bold{dt} is used in the kNN method for estimating entropy. \bold{k} is for the kth nearest neighbour (default = 3) and \bold{dt} is for the type of distance between samples which has currently two value options (1 for Eclidean distance, and 2(default) for Maximum distance).

}
\value{
The function returns the statistic for two-sample test of \bold{s0,s1}.
}
\references{ 

Ma, Jian. Two-Sample Test with Copula Entropy. arXiv preprint arXiv:2307.07247, 2023.

}

\examples{

library(mnormt)
rho <- 0.5
sigma <- matrix(c(1,rho,rho,1),2,2)
s0 <- rmnorm(600,c(0,0),sigma)
s1 <- rmnorm(500,c(5,5),sigma)
tst(s0,s1)

}
\keyword{two-sample test}
