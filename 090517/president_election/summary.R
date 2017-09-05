rm(list=ls())

library(ggplot2)


pdf("Polling_plots.pdf", height=8, width=7)


### Moon Jae In
MJI_dat = read.delim("MJI/data.txt", header=T, as.is=T)
MJI_results = read.delim("MJI/results.txt", header=T, as.is=T)
ggplot(MJI_results, aes(days)) + 
  geom_line(aes(y=p), colour="blue") + 
  geom_ribbon(aes(ymin=plwr, ymax=pupr), alpha=0.2) +
  geom_point(data = MJI_dat, mapping = aes(days, p*100)) +
  labs(title="Moon Jae In", x="Days (2017/1/1 as day 0)", y="Support level(%)") +
  theme(plot.title = element_text(hjust = 0.5))

### Ahn Hee Jung
AHJ_dat = read.delim("AHJ/data.txt", header=T, as.is=T)
AHJ_results = read.delim("AHJ/results.txt", header=T, as.is=T)
ggplot(AHJ_results, aes(days)) + 
  geom_line(aes(y=p), colour="blue") + 
  geom_ribbon(aes(ymin=plwr, ymax=pupr), alpha=0.2) +
  geom_point(data = AHJ_dat, mapping = aes(days, p*100)) +
  labs(title="Ahn Hee Jung", x="Days (2017/1/1 as day 0)", y="Support level(%)") +
  theme(plot.title = element_text(hjust = 0.5))

### Ahn Cheol Soo
ACS_dat = read.delim("ACS/data.txt", header=T, as.is=T)
ACS_results = read.delim("ACS/results.txt", header=T, as.is=T)
ggplot(ACS_results, aes(days)) + 
  geom_line(aes(y=p), colour="blue") + 
  geom_ribbon(aes(ymin=plwr, ymax=pupr), alpha=0.2) +
  geom_point(data = ACS_dat, mapping = aes(days, p*100)) +
  labs(title="Ahn Cheol Soo", x="Days (2017/1/1 as day 0)", y="Support level(%)") +
  theme(plot.title = element_text(hjust = 0.5))

### Hwang Gyo Ahn
HGA_dat = read.delim("HGA/data.txt", header=T, as.is=T)
HGA_results = read.delim("HGA/results.txt", header=T, as.is=T)
ggplot(HGA_results, aes(days)) + 
  geom_line(aes(y=p), colour="blue") + 
  geom_ribbon(aes(ymin=plwr, ymax=pupr), alpha=0.2) +
  geom_point(data = HGA_dat, mapping = aes(days, p*100)) +
  labs(title="Hwang Gyo Ahn", x="Days (2017/1/1 as day 0)", y="Support level(%)") +
  theme(plot.title = element_text(hjust = 0.5))

### Yoo Seung Min
YSM_dat = read.delim("YSM/data.txt", header=T, as.is=T)
YSM_results = read.delim("YSM/results.txt", header=T, as.is=T)
ggplot(YSM_results, aes(days)) + 
  geom_line(aes(y=p), colour="blue") + 
  geom_ribbon(aes(ymin=plwr, ymax=pupr), alpha=0.2) +
  geom_point(data = YSM_dat, mapping = aes(days, p*100)) +
  labs(title="Yoo Seung Min", x="Days (2017/1/1 as day 0)", y="Support level(%)") +
  theme(plot.title = element_text(hjust = 0.5))


### Lee Jae Myung
LJM_dat = read.delim("LJM/data.txt", header=T, as.is=T)
LJM_results = read.delim("LJM/results.txt", header=T, as.is=T)
ggplot(LJM_results, aes(days)) + 
  geom_line(aes(y=p), colour="blue") + 
  geom_ribbon(aes(ymin=plwr, ymax=pupr), alpha=0.2) +
  geom_point(data = LJM_dat, mapping = aes(days, p*100)) +
  labs(title="Lee Jae Myung", x="Days (2017/1/1 as day 0)", y="Support level(%)") +
  theme(plot.title = element_text(hjust = 0.5))


### Ban Ki Moon
BKM_dat = read.delim("BKM/data.txt", header=T, as.is=T)
BKM_results = read.delim("BKM/results.txt", header=T, as.is=T)
ggplot(BKM_results, aes(days)) + 
  geom_line(aes(y=p), colour="blue") + 
  geom_ribbon(aes(ymin=plwr, ymax=pupr), alpha=0.2) +
  geom_point(data = BKM_dat, mapping = aes(days, p*100)) +
  labs(title="Ban Ki Moon", x="Days (2017/1/1 as day 0)", y="Support level(%)") +
  theme(plot.title = element_text(hjust = 0.5))

### Hong Jun Pyo
HJP_dat = read.delim("HJP/data.txt", header=T, as.is=T)
HJP_results = read.delim("HJP/results.txt", header=T, as.is=T)
ggplot(HJP_results, aes(days)) + 
  geom_line(aes(y=p), colour="blue") + 
  geom_ribbon(aes(ymin=plwr, ymax=pupr), alpha=0.2) +
  geom_point(data = HJP_dat, mapping = aes(days, p*100)) +
  labs(title="Hong Jun Pyo", x="Days (2017/1/1 as day 0)", y="Support level(%)") +
  theme(plot.title = element_text(hjust = 0.5))



dev.off()

#### Combined plot

pdf("Poll_of_Polls.pdf", height=6, width=10)

MJI_tot <- data.frame(MJI_results,name="Moon Jae In")
AHJ_tot <- data.frame(AHJ_results,name="Ahn Hee Jung")
HGA_tot <- data.frame(HGA_results,name="Hwang Gyo Ahn")
ACS_tot <- data.frame(ACS_results,name="Ahn Cheol Soo")
LJM_tot <- data.frame(LJM_results,name="Lee Jae Myung")
YSM_tot <- data.frame(YSM_results,name="Yoo Seung Min")
BKM_tot <- data.frame(BKM_results,name="Ban Ki Moon")
HJP_tot <- data.frame(HJP_results,name="Hong Jun Pyo")

tot_results <- rbind(MJI_tot,AHJ_tot,HGA_tot,ACS_tot,LJM_tot,YSM_tot,BKM_tot,HJP_tot)

ggplot(tot_results,aes(x=days,y=p)) +
  geom_line(aes(colour=name),show.legend = NA) +
  geom_ribbon(aes(ymin=plwr, ymax=pupr, fill=name), show.legend = NA, alpha=0.2) +
  labs(title="Poll of Polls", x="Days (2017/1/1 as day 0)", y="Support level(%)") +
  theme(legend.title=element_blank()) +
  theme(plot.title = element_text(hjust = 0.5))

  

dev.off()



#############################################################
### 텍스트 파일명 입력
#############################################################

plot_results <- data.frame(date=MJI_results$date, MJI=NA, AHJ=NA, HGA=NA, ACS=NA, LJM=NA, YSM=NA, BKM=NA, HJP=NA,
                           MJI_upr=NA, MJI_lwr=NA, AHJ_upr=NA, AHJ_lwr=NA, HGA_upr=NA, HGA_lwr=NA,
                           ACS_upr=NA, ACS_lwr=NA, LJM_upr=NA, LJM_lwr=NA, YSM_upr=NA, YSM_lwr=NA,
                           BKM_upr=NA, BKM_lwr=NA, HJP_upr=NA, HJP_lwr=NA)





## Plot data


#Moon Jae In

for (i in 1:nrow(plot_results)) {
  j <- which(plot_results$date[i]==MJI_tot$date)
  if (length(j)==1) {
    plot_results$MJI[i] <- MJI_tot$p[j]
    plot_results$MJI_upr[i] <- MJI_tot$pupr[j]
    plot_results$MJI_lwr[i] <- MJI_tot$plwr[j]
  }
  else {
    plot_results$MJI[i] <- 0
    plot_results$MJI_upr[i] <- 0
    plot_results$MJI_lwr[i] <- 0
  }
}


#Ahn Hee Jung

for (i in 1:nrow(plot_results)) {
  j <- which(plot_results$date[i]==AHJ_tot$date)
  if (length(j)==1) {
    plot_results$AHJ[i] <- AHJ_tot$p[j]
    plot_results$AHJ_upr[i] <- AHJ_tot$pupr[j]
    plot_results$AHJ_lwr[i] <- AHJ_tot$plwr[j]
  }
  else {
    plot_results$AHJ[i] <- 0
    plot_results$AHJ_upr[i] <- 0
    plot_results$AHJ_lwr[i] <- 0
  }
}

#Hwang Gyo Ahn

for (i in 1:nrow(plot_results)) {
  j <- which(plot_results$date[i]==HGA_tot$date)
  if (length(j)==1) {
    plot_results$HGA[i] <- HGA_tot$p[j]
    plot_results$HGA_upr[i] <- HGA_tot$pupr[j]
    plot_results$HGA_lwr[i] <- HGA_tot$plwr[j]
  }
  else {
    plot_results$HGA[i] <- 0
    plot_results$HGA_upr[i] <- 0
    plot_results$HGA_lwr[i] <- 0
  }
}


#Ahn Cheol Soo

for (i in 1:nrow(plot_results)) {
  j <- which(plot_results$date[i]==ACS_tot$date)
  if (length(j)==1) {
    plot_results$ACS[i] <- ACS_tot$p[j]
    plot_results$ACS_upr[i] <- ACS_tot$pupr[j]
    plot_results$ACS_lwr[i] <- ACS_tot$plwr[j]
  }
  else {
    plot_results$ACS[i] <- 0
    plot_results$ACS_upr[i] <- 0
    plot_results$ACS_lwr[i] <- 0
  }
}


#Lee Jae Myung

for (i in 1:nrow(plot_results)) {
  j <- which(plot_results$date[i]==LJM_tot$date)
  if (length(j)==1) {
    plot_results$LJM[i] <- LJM_tot$p[j]
    plot_results$LJM_upr[i] <- LJM_tot$pupr[j]
    plot_results$LJM_lwr[i] <- LJM_tot$plwr[j]
  }
  else {
    plot_results$LJM[i] <- 0
    plot_results$LJM_upr[i] <- 0
    plot_results$LJM_lwr[i] <- 0
  }
}


#Yoo Seung Min

for (i in 1:nrow(plot_results)) {
  j <- which(plot_results$date[i]==YSM_tot$date)
  if (length(j)==1) {
    plot_results$YSM[i] <- YSM_tot$p[j]
    plot_results$YSM_upr[i] <- YSM_tot$pupr[j]
    plot_results$YSM_lwr[i] <- YSM_tot$plwr[j]
  }
  else {
    plot_results$YSM[i] <- 0
    plot_results$YSM_upr[i] <- 0
    plot_results$YSM_lwr[i] <- 0
  }
}


#Ban Ki Moon

for (i in 1:nrow(plot_results)) {
  j <- which(plot_results$date[i]==BKM_tot$date)
  if (length(j)==1) {
    plot_results$BKM[i] <- BKM_tot$p[j]
    plot_results$BKM_upr[i] <- BKM_tot$pupr[j]
    plot_results$BKM_lwr[i] <- BKM_tot$plwr[j]
  }
  else {
    plot_results$BKM[i] <- 0
    plot_results$BKM_upr[i] <- 0
    plot_results$BKM_lwr[i] <- 0
  }
}

#Hong Jun Pyo

for (i in 1:nrow(plot_results)) {
  j <- which(plot_results$date[i]==HJP_tot$date)
  if (length(j)==1) {
    plot_results$HJP[i] <- HJP_tot$p[j]
    plot_results$HJP_upr[i] <- HJP_tot$pupr[j]
    plot_results$HJP_lwr[i] <- HJP_tot$plwr[j]
  }
  else {
    plot_results$HJP[i] <- 0
    plot_results$HJP_upr[i] <- 0
    plot_results$HJP_lwr[i] <- 0
  }
}


write.table(plot_results, "plot_results.txt", sep="\t", quote=F, col.names=T, row.names=F)

