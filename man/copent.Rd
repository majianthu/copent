\name{copent}
\alias{copent}
\title{ Estimating copula entropy }
\description{

Estimating copula entropy nonparametrically.

}
\usage{
copent(x,k=3,dt=2)
}
\arguments{
  \item{x}{ data with each row as a sample}
  \item{k}{ kth nearest neighbour, default = 3}
  \item{dt}{ the type of distance between samples, 1 for Eclidean distance; 2 for Maximum distance}
}
\details{

This program involves estimating copula entropy from data nonparametrically. It was proposed in Ma and Sun (2008, 2011). 

The algorithm composes of two simple steps: estimating empirical copula by rank statistic using \code{\link{construct_empirical_copula}} and then estimating copula entropy with kNN method using \code{\link{entknn}} proposed in Kraskov et al (2004).

The argument \bold{x} is for the data with each row as a sample from random variables. The argument \bold{k} and \bold{dt} is used in the kNN method for estimating entropy. \bold{k} is for the kth nearest neighbour (default = 3) and \bold{dt} is for the type of distance between samples which has currently two value options (1 for Eclidean distance, and 2(default) for Maximum distance).

Copula Entropy is proved to be equivalent to negative mutual information so this program can also be used to estimate multivariate mutual information.

}
\value{
The function returns \emph{negative} value of copula entropy of data \bold{x}.
}
\references{ 

Ma, J., & Sun, Z. (2011). Mutual information is copula entropy. \emph{Tsinghua Science & Technology}, \bold{16}(1): 51-54. See also arXiv preprint arXiv:0808.0845, 2008.

Kraskov, A., St\"ogbauer, H., & Grassberger, P. (2004). Estimating Mutual Information. \emph{Physical Review E}, \bold{69}(6), 66138.

}

\examples{

library(mnormt)
rho <- 0.5
sigma <- matrix(c(1,rho,rho,1),2,2)
x <- rmnorm(500,c(0,0),sigma)
ce1 <- copent(x,3,2)

}
\keyword{copula entropy}
