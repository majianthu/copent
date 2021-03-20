[![CRAN](https://www.r-pkg.org/badges/version/copent)](https://cran.r-project.org/package=copent)
# copent
R package for Estimating Copula Entropy and Transfer Entropy

#### Introduction
Copula Entropy is a mathematical concept for statistical independence measurement [1]. In bivariate case, Copula Entropy is proved to be equivalent to Mutual Information. Different from Pearson Correlation Coefficient, Copula Entropy is defined for non-linear, high-order and multivariate cases, which makes it universally applicable.

It enjoys wide applications, including but not limited to：

* Structure Learning;

* Variable Selection [2];

* Causal Discovery (Estimating Transfer Entropy) [3].

The nonparametric methods for estimating copula entropy and transfer entropy are implemented. The method for estimating copula entropy composes of two simple steps: estimating empirical copula by rank statistic and estimating copula entropy with kNN method. 

The method for estimating transfer entropy composes of two steps: estimating three copula entropy terms and then calculate transfer entropy from the estimated copula entropies. 

An preprint paper on the copent package is [available](https://arxiv.org/abs/2005.14025) on arXiv. For more information, please refer to [1-3]. For more information in Chinese, please follow [this link](http://blog.sciencenet.cn/blog-3018268-978326.html).

#### Functions
* copent -- estimating copula entropy;
* construct_empirical_copula -- the first step of the algorithm, which estimates empirical copula for data by rank statistics;
* entknn -- the second step of the algorithm, which estimates copula entropy from empirical copula with kNN method.
* ci -- conditional independence testing based on copula entropy
* transent -- estimating transfer entropy via copula entropy

#### Usage 
##### Install the package
The package can be installed from CRAN directly:
```
install.packages("copent")
```
The package can be installed from Github with `install_github` function in the **devtools** package:
```
install_github("majianthu/copent")
```
The installation can also be completed offline by three steps:
1. Download the depository as .zip file and unzip the file into `copent-master` folder
2. Run the following command and get the archive file `copent_0.1.tar.gz` 
```
R CMD build copent-master
```
3. Install the package from the archive file `copent_0.1.tar.gz` in R
##### Code Examples
###### Example 1. Estimating copula entropy of bivariate Gaussian rvs.
```
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
```
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
#### References
1. Ma Jian, Sun Zengqi. Mutual information is copula entropy. Tsinghua Science & Technology, 2011, 16(1): 51-54. See also arXiv preprint, arXiv:0808.0845, 2008.

2. Ma Jian. Variable Selection with Copula Entropy. arXiv preprint arXiv:1910.12389, 2019.

3. Ma Jian. Estimating Transfer Entropy via Copula Entropy. arXiv preprint arXiv:1910.04375, 2019.

4. Ma Jian. copent: Estimating Copula Entropy in R. arXiv Preprint arXiv:2005.14025, 2020.
#### License
GPL (>=2)
