[![CRAN](https://www.r-pkg.org/badges/version/copent)](https://cran.r-project.org/package=copent)
# copent
R package for Estimating Copula Entropy and Transfer Entropy

#### Introduction
This package implements the methods for estimating copula entropy, transfer entropy, and the statistics for multivariate normality test and two-sample test based on copula entropy.

Copula Entropy is a mathematical concept for statistical independence measurement [1]. In bivariate case, Copula Entropy is proved to be equivalent to Mutual Information. Different from Pearson Correlation Coefficient, Copula Entropy is defined for non-linear, high-order and multivariate cases, which makes it universally applicable.

It enjoys wide applications, including but not limited to：
* Structure Learning;
* Variable Selection [2];
* Causal Discovery (Estimating Transfer Entropy) [3];
* Multivariate Normality Test [5].
* Two-Sample Test [6].
* Change Point Detection [7]

The nonparametric methods for estimating copula entropy and transfer entropy are implemented. The method for estimating copula entropy composes of two simple steps: estimating empirical copula by rank statistic and estimating copula entropy with kth-Nearest-Neighbour method. 

The method for estimating transfer entropy composes of two steps: estimating three copula entropy terms and then calculate transfer entropy from the estimated copula entropy terms. 

The method for estimating the statistic for testing multivariate normality composes of two steps: estimating the copula entropy of random variables and calculating the copula entropy of the Gaussian variables with same covariance with the estimated covariance. The statistic is then derived as the difference between these two copula entropies.

The method for estimating the statistic for two-sample test is also implemented. The test statistic is defined as the difference between the copula entropies between the null hypothesis and the alternative of two-sample test. The method for multivariate change point detection with copula entropy based two-sample test is also implemented.

An preprint paper on the copent package is [available](https://arxiv.org/abs/2005.14025) on arXiv. For more information, please refer to [1-3]. For more information in Chinese, please follow [this link](http://blog.sciencenet.cn/blog-3018268-978326.html).

#### Functions
* copent -- estimating copula entropy;
* construct_empirical_copula -- the first step of the algorithm, which estimates empirical copula for data by rank statistics;
* entknn -- the second step of the algorithm, which estimates copula entropy from empirical copula with kNN method.
* ci -- conditional independence testing based on copula entropy
* transent -- estimating transfer entropy via copula entropy
* mvnt -- estimating the statistic for testing multivariate normality based on copula entropy
* tst -- estimating the statistic for non-parametric multivariate two-sample test based on copula entropy
* cpd -- single change point detection with copula entropy based two-sample test
* mcpd -- multiple change point detection with copula entropy based two-sample test

#### Usage 
##### Install the package
The package can be installed from CRAN directly:
```
install.packages("copent")
```
The package can be installed from Github with `install_github` function in the **devtools** package:
```
devtools::install_github("majianthu/copent")
```

##### Code Examples
###### Example 1. Estimating copula entropy of bivariate Gaussian rvs.
```r
# Example for library "copent"
library(mnormt)
library(copent)
rho = 0.5
sigma = matrix(c(1,rho,rho,1),2,2)
x = rmnorm(500,c(0,0),sigma)
ce1 = copent(x)
```
###### Example 2. Estimating transfer entropy.
The data used in this example is the UCI Beijing PM2.5 data which include the PM2.5 and meterological factors obeservations in Beijing. The aim of the example is to infere the casuality from meterological factor (pressure) to PM2.5 from this obeservational data by estimating transfer entropy. Here transfer entropy is estimated via three copula entropy terms. More information on this example, please refer to [4].
```r
library(copent) 
dir = "https://archive.ics.uci.edu/ml/machine-learning-databases/00381/"
data = read.csv(paste(dir,"PRSA_data_2010.1.1-2014.12.31.csv",sep=""))
pm25 = data[2200:2700, 6]
pressure = data[2200:2700, 9]
te1 = 0
for (lag in 1:24){
  te1[lag] = transent(pm25,pressure,lag)
}
x11()
plot(te1, xlab = "lag (hours)", ylab = "Transfer Entropy", main = "Pressure")
lines(te1)
```
###### Example 3. Multivariate Normality Test.
```r
library(copent)
library(mnormt)
rho <- 0.5
sigma <- matrix(c(1,rho,rho,1),2,2)
x <- rmnorm(1000,c(0,0),sigma)
mvnt(x)
```
###### Example 4. Two-Sample Test.
```r
library(copent)
library(mnormt)
rho <- 0.5
sigma <- matrix(c(1,rho,rho,1),2,2)
s0 <- rmnorm(600,c(0,0),sigma)
s1 <- rmnorm(500,c(5,5),sigma)
tst(s0,s1)
```
###### Example 5. Change Point Detection.
```r
library(copent)
library(mnormt)
rho1 = 0.2; n1 = 20
x1 = rmnorm(n1,c(0,0),matrix(c(1,rho1,rho1,1),2,2))
x2 = rmnorm(n1,c(10,10),matrix(c(1,rho1,rho1,1),2,2))
x3 = rmnorm(n1,c(5,5),matrix(c(1,rho1,rho1,1),2,2))
x4 = rmnorm(n1,c(1,0),matrix(c(1,rho1,rho1,1),2,2))
x = rbind(x1,x2,x3,x4)
mcpd(x,n=15)
```

#### References
1. Ma, Jian, Sun Zengqi. Mutual information is copula entropy. Tsinghua Science & Technology, 2011, 16(1): 51-54. See also arXiv preprint, arXiv:0808.0845, 2008.
2. Ma, Jian. Variable Selection with Copula Entropy. arXiv preprint arXiv:1910.12389, 2019.
3. Ma, Jian. Estimating Transfer Entropy via Copula Entropy. arXiv preprint arXiv:1910.04375, 2019.
4. Ma, Jian. copent: Estimating Copula Entropy in R. arXiv preprint arXiv:2005.14025, 2020.
5. Ma, Jian. Multivariate Normality Test with Copula Entropy. arXiv preprint arXiv:2206.05956, 2022.
6. Ma, Jian. Two-Sample Test with Copula Entropy. arXiv preprint arXiv:2307.07247, 2023.
7. Ma, Jian. Change Point Detection with Copula Entropy based Two-Sample Test. arXiv preprint arXiv:2403.07892, 2024.
#### License
GPL (>=2)
