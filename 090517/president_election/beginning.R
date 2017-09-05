rm(list=ls())

library(gam)
library(ggplot2)


#############################################################
### 대상 후보 이니셜 변경(MJI, AHJ, ACS, HGA, LJM, YSM, BKM)
#############################################################

rdata = read.delim("./MJI/poll_data.txt", header=T, as.is=T)

p <- rdata[,3] / 100
y <- log(p/(1-p)) #logit 변환

rdata$date <- as.Date(rdata$date)
date <- rdata$date
x <- rdata$pollster

days <- rdata$days
totdays <- seq(rdata$days[1], max(days))
totdate <- as.Date(totdays, origin="2017-01-01")

dat <- data.frame(x,y,date,days)
table<-table(dat[1])


## 조사기관 1번 등장한 데이터 제거

name <- names(which(table==1))

for (i in 1:length(name)) {
  dat <- dat[-(which(dat[,1] == name[i])),]  
}



n1 <- length(totdays) #(totdays의 갯수 세는 식으로 변환)
a <- rep("리얼미터 ",n1)
b <- as.numeric(rep(0.9, n1))
c <- log(b/(1-b))
totdate_1 <- as.numeric(totdate)-as.numeric(as.Date("2017-01-01"))
add <- data.frame(a,c,totdate,totdate_1)
colnames(add) <- colnames(dat)
weight <- c(rep(1,nrow(dat)),rep(0,nrow(add)))
dat <- rbind(dat, add)

n<-dim(dat)[1]

table<-table(dat[1])


y <- dat$y
p <- exp(y)/(1+exp(y))
x <- dat$x

date <- dat$date
days <- dat$days
dat$p <- p


## Make a design matrix
designpoll <- model.matrix(~x)

datt <- list(y = dat$y, days = dat$days, designpoll = designpoll)


#############################################################
### 황교안 : span = 0.5, 나머지 : span = 0.25
#############################################################

## gam
gam.o <- gam::gam(y ~ lo(days, span=0.25, degree =2) + designpoll, weights=weight, data=datt)


results_mid<-cbind(days,as.vector(gam.o$fitted.values), as.vector(gam.o$var))
colnames(results_mid)<-c("days", "지지율", "SE")


# SE interpolation
n2 <- n-n1
given <- results_mid[1:n2,]
target <- results_mid[(n2+1):n,]

SE_approx <- approx(given[,1],given[,3],xout=target[,1],method="linear")

results_approx <- cbind(as.vector(SE_approx$x),target[,2],sqrt(as.vector(SE_approx$y)))

dat <- dat[1:n2,]


# delta의 sum 효과 0으로 만들기
beta0 <- gam.o$coefficients[1]
betapoll <- gam.o$coefficients[-c(1:3)]
delta <- sum(designpoll%*%betapoll)/n2

loess_gam <- gam.o$fitted.values - designpoll%*%betapoll + delta
results_approx[,2]<-loess_gam[(n2+1):n,]


# 조사기관의 bias

a <- designpoll%*%betapoll - delta
bias <- exp(loess_gam)/(1+exp(loess_gam))^2 * a
rownames(bias) <- x
colnames(bias) <- "bias"
pollster_bias <- data.frame(pollster = unique(x),bias = NA)

for (i in 1:nrow(pollster_bias)) {
  pollster_bias$bias[i] <- mean(bias[which(pollster_bias$pollster[i]==rownames(bias))])
}

yhat <- results_approx[,2]
se <- results_approx[,3]



## confidence interval

#상/하위 10% 구간의 se 조정 -> 위로 뻗치는거 방지
n <- dim(results_approx)[1]
n_round <- round(n/10)



se_low <- se[n_round]
se_upp <- se[n-n_round]
for (i in (1:n_round)){
  se[i] <- se_low* (0.9 + ((1-0.9)/n_round)*i)
}

for (i in ((n-n_round):n)){
  se[i] <- se_upp* (1 + ((1-0.9)/n_round)*(i-n+n_round))
}

lwr <- yhat - 1.96*se
upr <- yhat + 1.96*se




## Inverse logit, results = confidence interval

phat <- exp(yhat)/(1+exp(yhat)) *100
plwr <- exp(lwr)/(1+exp(lwr)) *100
pupr <- exp(upr)/(1+exp(upr)) *100

results <- data.frame(phat = phat, plwr = plwr, pupr = pupr, date = totdate, days = totdays)
colnames(results)<-c("p","plwr","pupr","date", "days")



#############################################################
### 대상 후보 이니셜 변경(MJI, AHJ, ACS, HGA, LJM, YSM, BKM)
#############################################################


write.table(dat, "HJP/data.txt", sep="\t", quote=F, row.names=F)
write.table(results, "HJP/results.txt", sep="\t", quote=F, col.names=T, row.names=F)
write.table(pollster_bias, "HJP/bias.txt", sep="\t", quote=F, col.names=T, row.names=F)


