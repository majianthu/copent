\name{mcpd}
\alias{mcpd}
\title{ Multiple change point detection with copula entropy based two-sample test }
\description{

Multiple change point detection with copula entropy based two-sample test.

}
\usage{
mcpd(x,maxp=5,thd=0.13,minseglen=10,n=15,k=3,dt=2,ncores=0)
}
\arguments{
  \item{x}{ data with each row as a sample of d-dimensional random variables}
  \item{maxp}{ maximal number of change points, default = 5}
  \item{thd}{ threshold of the statistic of two-sample test for detecting change points, default = 0.13}
  \item{minseglen}{ minimal length of binary segmentation, default = 10}
  \item{n}{ the parameter used by two-sample test, default = 15}
  \item{k}{ kth nearest neighbour, default = 3}
  \item{dt}{ the type of distance between samples, 1 for Eclidean distance; 2 for Maximum distance}
  \item{ncores}{ number of cores to be used for parallel computing, default = 0 for all the cores}
}
\details{

This program involves detecting multiple change points in univariate or multivariate time series data with copula entropy based two-sample test. It was proposed in Ma (2024). The method is a combination of binary segmentation and single change point detection implemented in \code{\link{cpd}}.

The argument \bold{x} is for the data with each row as a sample of d-dimensional random variables. The argument \bold{maxp} is for the maximal number of change points. The argument \bold{thd} is for the threshold of the statistic of two-sample test for detecting a change point used in \code{\link{cpd}}. The argument \bold{minseglen} is for the minimal length of each segment in binary segmentation. If the length of a segment is shorter than \bold{minseglen}, then no detection will be performed on the segment. The argument \bold{k} and \bold{dt} is used in the kNN method for estimating entropy. \bold{k} is for the kth nearest neighbour (default = 3) and \bold{dt} is for the type of distance between samples which has currently two value options (1 for Eclidean distance, and 2(default) for Maximum distance). The argument \bold{ncores} is for the number of cores to be used for parallel computing. If the default 0 is used, then all the cores will be used.

}
\value{
The function returns a list containing
  \item{maxstat}{the maximal statistics of the detected change points}
  \item{pos}{the change points detected}
}
\references{ 

Ma, Jian. Change Point Detection with Copula Entropy based Two-Sample Test. arXiv preprint arXiv:2403.07892, 2024.

}

\examples{

x = c(rnorm(15,0,1),rnorm(10,0,10),rnorm(10,0,1))
mcpd(x,thd=0.15,ncores=2)


}
\keyword{change point detection}
