##################################################################################
###  Estimating Copula Entropy and Transfer Entropy
###  2022-10-01
###  by MA Jian (Email: majian03@gmail.com)
###
###  Parameters
###   x		: N * d data, N samples, d dimensions
###   k 	: kth nearest neighbour, parameter for kNN entropy estimation 
###   dt	: distance type [1: 'Euclidean', others: 'Maximum distance']
###   lag	: time lag
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
