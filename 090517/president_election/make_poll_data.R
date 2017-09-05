rm(list=ls())

#############################################################
### 텍스트 파일명 입력
#############################################################

rdata = read.delim("2017_0321.txt", header=T, as.is=T)
rdata$date <- as.Date(rdata$date)


newdata = data.frame(pollster=rdata$pollster, date=rdata$date, 
                     MJI=rdata$MoonJaeIn,
                     AHJ=rdata$AhnHeeJeong,
                     ACS=rdata$AhnCheolSoo,
                     HGA=rdata$HwangGyoAhn,
                     LJM=rdata$LeeJaeMyung,
                     YSM=rdata$YooSeungMin,
                     BKM=rdata$BanKiMoon,
                     HJP=rdata$홍준표,
                     days=as.numeric(rdata$date)-as.numeric(as.Date("2017-01-01")),
                     stringsAsFactors = FALSE)


newdata = newdata[order(newdata$days), ]

## remove NA

makeData = function(x) {
  rid = is.na(x[,3])
  x = x[!rid, ]
  x$others = 100 - x[,3]
  x
}

MJIdata = makeData(newdata[,c(1,2,3,11)])
AHJdata = makeData(newdata[,c(1,2,4,11)])
ACSdata = makeData(newdata[,c(1,2,5,11)])
HGAdata = makeData(newdata[,c(1,2,6,11)])
LJMdata = makeData(newdata[,c(1,2,7,11)])
YSMdata = makeData(newdata[,c(1,2,8,11)])
BKMdata = makeData(newdata[,c(1,2,9,11)])
HJPdata = makeData(newdata[,c(1,2,10,11)])

dir.create("MJI")
dir.create("AHJ")
dir.create("ACS")
dir.create("HGA")
dir.create("LJM")
dir.create("YSM")
dir.create("BKM")
dir.create("HJP")

write.table(MJIdata, "MJI/poll_data.txt", sep="\t", quote=F, row.names=F)
write.table(AHJdata, "AHJ/poll_data.txt", sep="\t", quote=F, row.names=F)
write.table(ACSdata, "ACS/poll_data.txt", sep="\t", quote=F, row.names=F)
write.table(HGAdata, "HGA/poll_data.txt", sep="\t", quote=F, row.names=F)
write.table(LJMdata, "LJM/poll_data.txt", sep="\t", quote=F, row.names=F)
write.table(YSMdata, "YSM/poll_data.txt", sep="\t", quote=F, row.names=F)
write.table(BKMdata, "BKM/poll_data.txt", sep="\t", quote=F, row.names=F)
write.table(HJPdata, "HJP/poll_data.txt", sep="\t", quote=F, row.names=F)


