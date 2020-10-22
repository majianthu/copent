[![CRAN](https://www.r-pkg.org/badges/version/copent)](https://cran.r-project.org/package=copent)
# copent
R package for Estimating Copula Entropy 

#### Introduction
Copula Entropy is a mathematical concept for statistical independence measurement [1]. In bivariate case, Copula Entropy is proved to be equivalent to Mutual Information. Different from Pearson Correlation Coefficient, Copula Entropy is defined for non-linear, high-order and multivariate cases, which makes it universally applicable.

It enjoys wide applications, including but not limited to：

* Structure Learning;

* Variable Selection [2];

* Causal Discovery (Estimating Transfer Entropy) [3].

This algorithm composes of two steps: estimating empirical copula density with rank statistics and estimating copula entropy from the estimated empirical copula density with kNN method. Since both steps are with non-parametric methods, the copent algorithm can be applied to any cases without making assumptions.

An preprint paper on the copent package is [available](https://arxiv.org/abs/2005.14025) on arXiv. For more information, please refer to [1-3]. For more information in Chinese, please follow [this link](http://blog.sciencenet.cn/blog-3018268-978326.html).

#### Functions
* copent -- main function;

* construct_empirical_copula -- the first step of the algorithm, which estimates empirical copula for data by rank statistics;

* entknn -- the second step of the algorithm, which estimates copula entropy from empirical copula with kNN method.

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
prsa2010data = read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/00381/PRSA_data_2010.1.1-2014.12.31.csv")
data = prsa2010data[2200:2700,c(6,9)]
tslag = 0
for (lag in 1:24){
  pm25a = data[1:(501-lag),1]
  pm25b = data[(lag+1):501,1]
  v1 = data[1:(501-lag),2]
  data1 = cbind(pm25a, pm25b, v1)
  tslag[lag] = copent(data1) - copent(data1[,c(1,2)]) - copent(data1[,c(1,3)]) 
}
x11()
plot(tslag, xlab = "lag (hours)", ylab = "Transfer Entropy", main = "Pressure")
lines(tslag)
```
#### References
1. Ma Jian, Sun Zengqi. Mutual information is copula entropy. Tsinghua Science & Technology, 2011, 16(1): 51-54. See also arXiv preprint, arXiv:0808.0845, 2008.

2. Ma Jian. Variable Selection with Copula Entropy. arXiv preprint arXiv:1910.12389, 2019.

3. Ma Jian. Estimating Transfer Entropy via Copula Entropy. arXiv preprint arXiv:1910.04375, 2019.

4. Ma Jian. copent: Estimating Copula Entropy in R. arXiv Preprint arXiv:2005.14025, 2020.
#### License
GPL (>=2)
