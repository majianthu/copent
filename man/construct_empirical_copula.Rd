\name{construct_empirical_copula}
\alias{construct_empirical_copula}
\title{ Construct empirical copula by rank statistic }
\description{

Construct empirical copula by rank statistic.

}
\usage{
construct_empirical_copula(x)
}
\arguments{
  \item{x}{ the data with each row as a sample}
}
\details{

This program involves estimating empirical copula from data by rank statistic nonparametrically. It was proposed in Ma and Sun (2008, 2011). The algorithm is the first step of estimating copula entropy \code{\link{copent}}.

The argument \bold{x} is for the data with each row as a sample from random variables. 

}
\value{
The function returns the estimated empirical copula of data \bold{x}.
}
\references{ 

Ma, J., & Sun, Z. (2011). Mutual information is copula entropy. \emph{Tsinghua Science & Technology}, \bold{16}(1): 51-54. See also \emph{ArXiv preprint}, arXiv: 0808.0845, 2008.

}

\examples{

library(mnormt)
rho <- 0.5
sigma <- matrix(c(1,rho,rho,1),2,2)
x <- rmnorm(500,c(0,0),sigma)
xc1 <- construct_empirical_copula(x)

}
\keyword{empirical copula; rank}
