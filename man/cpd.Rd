\name{cpd}
\alias{cpd}
\title{ Single change point detection with copula entropy based two-sample test }
\description{

Single change point detection with copula entropy based two-sample test.

}
\usage{
cpd(x,thd=0.13,n=15,k=3,dt=2,ncores=0)
}
\arguments{
  \item{x}{ data with each row as a sample of d-dimensional random variables}
  \item{thd}{ threshold of the statistic of two-sample test for detecting a change point, default = 0.13}
  \item{n}{ the argument used by two-sample test, default = 15}
  \item{k}{ kth nearest neighbour, default = 3}
  \item{dt}{ the type of distance between samples, 1 for Eclidean distance; 2 for Maximum distance. default = 2}
  \item{ncores}{ number of cores to be used for parallel computing, default = 0 for all the cores}
}
\details{

This program involves detecting single change point in univariate or multivariate time series data with copula entropy based two-sample test. It was proposed in Ma (2024), in which a group of two-sample tests are performed on time series data and the change point is considered to be associated with the maximum of the statistics of all the tests. 

The argument \bold{x} is for the data with each row as a sample of d-dimensional random variables. The argument \bold{thd} is for the threshold of the statistic of two-sample test for detecting a change point. If the maximum of the statistics of all the two-sample tests is below the threshold, no change point is detected. The argument \bold{n} is the argument used by the two-sample test function \code{\link{tst}}. The argument \bold{k} and \bold{dt} is used in the kNN method for estimating entropy. \bold{k} is for the kth nearest neighbour (default = 3) and \bold{dt} is for the type of distance between samples which has currently two value options (1 for Eclidean distance, and 2(default) for Maximum distance). The argument \bold{ncores} is for the number of cores to be used for parallel computing. If the default 0 is used, then all the cores will be used.

}
\value{
The function returns a list containing
  \item{stats}{the estimated statistics of all the two-sample tests}
  \item{maxstat}{the maximum of the estimated statistics}
  \item{pos}{the change point detected}
}
\references{ 

Ma, Jian. Change Point Detection with Copula Entropy based Two-Sample Test. arXiv preprint arXiv:2403.07892, 2024.

}

\examples{

x = c(rnorm(15,0,1),rnorm(15,0,10))
cpd(x,thd=0.15,ncores=2)

}
\keyword{change point detection}
