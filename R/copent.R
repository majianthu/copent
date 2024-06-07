##################################################################################
###  Estimating Copula Entropy and Transfer Entropy
###  2024-06-08
###  by MA Jian (Email: majian03@gmail.com)
###
###  Parameters
###   x	: N * d data, N samples, d dimensions
###   k	: kth nearest neighbour, parameter for kNN entropy estimation 
###   dt	: distance type [1: 'Euclidean', others: 'Maximum distance']
###   lag	: time lag
###   s0,s1	: two samples with same dimension
###   n	: repeat time of estimation
###   thd : threshold for the statistic of two-sample test
###   maxp : maximum number of change points
###   minseglen : minmum length of binary segmentation in change point detection
###   ncores : the number of cores used for parallel computing
###
###  References
###  [1] Jian Ma and Zengqi Sun. Mutual information is copula entropy. 
###      arXiv:0808.0845, 2008.
###  [2] Kraskov A, St\"ogbauer H, Grassberger P. Estimating mutual information. 
###      Physical review E, 2004, 69(6): 066138.
###  [3] Jian Ma. Estimating Transfer Entropy via Copula Entropy. 
###      arXiv preprint arXiv:1910.04375, 2019.
###  [4] Jian Ma. Multivariate Normality Test with Copula Entropy.
###      arXiv preprint arXiv:2206.05956, 2022.
###  [5] Ma, Jian. Two-Sample Test with Copula Entropy.
###      arXiv preprint arXiv:2307.07247, 2023.
###  [6] Ma, Jian. Change Point Detection with Copula Entropy based Two-Sample Test.
###      arXiv preprint arXiv:2403.07892, 2024.
##################################################################################
copent<-function(x,k=3,dt=2){
  xc = construct_empirical_copula(x)
  ce1 = -entknn(xc,k,dt)
  if(is.infinite(ce1)){ # log0
    N = dim(x)[1]; d = dim(x)[2];
    for(i in 1:d){
      max1 = max(abs(x[,i]))
      if(max1 > 0){x[,i] = x[,i] + max1 * 0.00000001 * runif(N)}
      else{x[,i] = runif(N)}
    }
    xc = construct_empirical_copula(x)
    ce1 = -entknn(xc,k,dt)
  }
  ce1
}

construct_empirical_copula<-function(x){
  dimx = dim(as.matrix(x));
  rx = dimx[1]; lx = dimx[2];  
  xrank = x
  for(i in 1:lx){
    xrank[,i] = rank(x[,i])
  }  
  xrank / rx
}

entknn<-function(x,k=3,dt=2){
  x = as.matrix(x)
  N = dim(x)[1];  d = dim(x)[2];  
  g1 = digamma(N) - digamma(k);  
  if (dt == 1){	# euciledean distance
    cd = pi^(d/2) / 2^d / gamma(1+d/2);	
    distx = as.matrix(dist(x));
  }
  else {	# maximum distance
    cd = 1;
    distx = as.matrix(dist(x,method = "maximum"));
  }  
  logd = 0;
  for(i in 1:N){
    distx[i,] = sort(distx[i,]);
    logd = logd + log( 2 * distx[i,k+1] ) * d / N;
  }  
  g1 + log(cd) + logd
}

ci<-function(x,y,z,k=3,dt=2){
  xyz = cbind(x,y,z)
  xz  = cbind(x,z)
  yz  = cbind(y,z)  
  copent(xyz,k,dt) - copent(xz,k,dt) - copent(yz,k,dt)
}

transent<-function(x,y,lag=1,k=3,dt=2){
  xl = length(x);  yl = length(y)
  if(xl > yl){ l = yl  }
  else { l = xl  }
  x1 = x[1:(l-lag)]
  x2 = x[(lag+1):l]
  y1 = y[1:(l-lag)]
  ci(x2,y1,x1,k,dt) 
}

mvnt<-function(x,k=3,dt=2){
  - 0.5 * log( det(cov(x)) ) - copent(x,k,dt)
}

tst<-function(s0,s1,n=12,k=3,dt=2){
  n0 = dim(s0)[1]
  n1 = dim(s1)[1]
  x = rbind(s0,s1)
  result = 0
  for(i in 1:n){
    y1 = c(rep(1,n0),rep(2,n1)) + runif(n0+n1, max = 0.0000001)
    y0 = c(rep(1,n0+n1)) + runif(n0+n1,max = 0.0000001)
    result = result + copent(cbind(x,y1),k,dt) - copent(cbind(x,y0),k,dt)
  }
  result/n
}

cpd <- function(x,thd=0.13,n=15,k=3,dt=2,ncores=0){
  x = as.matrix(x)
  len1 = dim(x)[1]
  stat1 = 0
  if(ncores == 0){nc = detectCores()}
  else{nc = ncores}
  cl = makeCluster(nc)
  stat1 = parLapply(
    cl,
    2:(len1-2),
    function(i){s0 = as.matrix(x[1:i,]); s1 = as.matrix(x[(i+1):len1,]); tst(s0,s1,n,k,dt)}
  )
  stopCluster(cl)
  stat1 = c(0,unlist(stat1))
  result = {}
  if(max(stat1)>thd){
    result$stats = stat1
    result$maxstat = max(stat1)
    result$pos = which(stat1 == max(stat1))+1
  }
  return(result)
}

mcpd <- function(x,maxp=5,thd=0.13,minseglen=10,n=15,k=3,dt=2,ncores=0){
  mresult = {}
  x = as.matrix(x)
  len1 = dim(x)[1]
  bisegs = matrix(c(1,len1-1),1,2)
  k = 1
  for(i in 1:maxp){
    if(i>dim(bisegs)[1]){ break } 
    ri = cpd(x[bisegs[i,1]:bisegs[i,2],],thd,n,k,dt,ncores)
    if(!is.null(ri)){
      ri$pos = ri$pos + bisegs[i,1] - 1
      mresult$maxstat[k] = ri$maxstat
      mresult$pos[k] = ri$pos
      k = k + 1
      if((ri$pos-bisegs[i,1])>minseglen) { bisegs = rbind(bisegs,c(bisegs[i,1],ri$pos-1)) }
      if((bisegs[i,2]-ri$pos+1)>minseglen) { bisegs = rbind(bisegs,c(ri$pos,bisegs[i,2])) }
    }
  }
  return(mresult)
}

