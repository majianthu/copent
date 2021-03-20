library(copent) 
dir = "https://archive.ics.uci.edu/ml/machine-learning-databases/00381/"
data = read.csv(paste(dir,"PRSA_data_2010.1.1-2014.12.31.csv",sep=""))
pm25 = data[2200:2700, 6]
pressure = data[2200:2700, 9]
te1 = 0
for (lag in 1:24){
  te1[lag] = transent(pm25,pressure,lag)
}

