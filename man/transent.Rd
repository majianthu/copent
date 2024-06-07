\name{transent}
\alias{transent}
\title{ Estimating transfer entropy via copula entropy }
\description{

Estimating transfer entropy via copula entropy nonparametrically.

}
\usage{
transent(x,y,lag=1,k=3,dt=2)
}
\arguments{
  \item{x}{ the data with 1 row}
  \item{y}{ the data with 1 row}
  \item{lag}{ time lag, >0}
  \item{k}{ kth nearest neighbour, default = 3}
  \item{dt}{ the type of distance between samples, 1 for Eclidean distance; 2 for Maximum distance}
}
\details{

This program involves estimating transfer entropy from \bold{y} to \bold{x} with time lag \bold{lag} via copula entropy nonparametrically. It was proposed in Ma (2019). 

The algorithm first prepare the data according to \bold{lag}, and then call \code{\link{ci}} for conditional independence testing.

The argument \bold{x,y} are for the data with 1 row as samples from random variables. The argument \bold{lag} is for time lag. The argument \bold{k} and \bold{dt} is used in the kNN method for estimating entropy. \bold{k} is for the kth nearest neighbour (default = 3) and \bold{dt} is for the type of distance between samples which has currently two value options (1 for Eclidean distance, and 2(default) for Maximum distance).

}
\value{
The function returns the value of transfer entropy from \bold{y} to \bold{x} with time lag \bold{lag}.
}
\references{ 

Ma, Jian. Estimating Transfer Entropy via Copula Entropy. arXiv preprint arXiv:1910.04375, 2019.

}

\examples{

library(copent)
num = 300
x = rnorm(num)
y = rnorm(num)
transent(y,x,2)

}
\keyword{transfer entropy}
