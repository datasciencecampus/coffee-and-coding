library(mice)

#Load data
DataK<-read.csv("adult.csv")

#Separate males and females to generate income
DataMale<-DataK[DataK$sex=="Male",]
DataFemale<-DataK[DataK$sex=="Female",]

#Create income for males and females
DataMale$IncomeN<-rnorm(1:nrow(DataMale),80000,20000)
DataFemale$IncomeN<-rnorm(1:nrow(DataFemale),55000,10000)

DataK_edit<-rbind(DataMale,DataFemale)

#Create numeric version of sex and subset to core variables
DataK_edit$SexN<-ifelse(DataK_edit$sex=="Female",1,2)
DataK_editSub<-DataK_edit[c("age","IncomeN","SexN")]

#Simulate missingness
Get<-ampute(DataK_editSub)
patterns <- Get$patterns
patterns[1,3]<-1

#Missing Completely at Random
MCAR<-ampute(DataK_editSub, prop=0.3, patterns=patterns, mech="MCAR")
MCAR_c<-MCAR$data
MCAR_m<-MCAR$amp

#Plot MCAR
MCARcompleteDis<-hist(MCAR_c$IncomeN, main="Distribution of Income (complete data)", xlab="Income")
abline(v=mean(MCAR_c$IncomeN))
text(100000,5500,"Mean=$71736.58",col="red")
MCARmissingDis<-hist(MCAR_m$IncomeN, main="Distribution of Income (MCAR)", xlab="Income")
abline(v=mean(MCAR_m$IncomeN, na.rm=TRUE))
text(100000,5000,"Mean=$71754.2",col="red")

#Missing at Random
#Modify probability of missing for males and females separately
# MAR_DataMale<-DataK_editSub[DataK_editSub$SexN==2,]
# MAR_DataFemale<-DataK_editSub[DataK_editSub$SexN==1,]
# 
# MAR_Male<-ampute(MAR_DataMale,prop=0.6,patterns=patterns, mech="MAR")
# MAR_Female<-ampute(MAR_DataFemale,prop=0.2, patterns=patterns, mech="MAR")
# MAR<-rbind(MAR_Male$amp,MAR_Female$amp)
MAR<-ampute(DataK_editSub, prop=0.3, patterns=patterns, mech="MAR")
MAR_c<-MAR$data
MAR_m<-MAR$amp
MAR_m$Missing<-ifelse(is.na(MAR_m$IncomeN),1,0)
MAR_m$SexO<-ifelse(MAR_m$SexN==1,"Female","Male")
MissingSex<-table(MAR_m$SexO,MAR_m$Missing)
PlotMiss<-mosaicplot(MissingSex, main="Proportion Missing for Income- Male vs. Females")

#Plot MAR
MARcompleteDis<-hist(MAR_c$IncomeN, main="Distribution of Income (complete data)", xlab="Income")
abline(v=mean(MAR_c$IncomeN))
text(100000,5500,"Mean=$71736.58",col="red")
MARmissingDis<-hist(MAR_m$IncomeN, main="Distribution of Income (MAR)", xlab="Income")
abline(v=mean(MAR_m$IncomeN, na.rm=TRUE))
text(100000,4500,"Mean=71239.59",col="red")

#Not Missing at Random
MNAR<-ampute(DataK_editSub, prop=0.3, patterns=patterns, mech="MNAR")
MNAR_c<-MNAR$data
MNAR_m<-MNAR$amp

#Plot MNAR
MNARcompleteDis<-hist(MNAR_c$IncomeN, main="Distribution of Income (complete data)", xlab="Income")
abline(v=mean(MNAR_c$IncomeN))
text(100000,5500,"Mean=$71736.58",col="red")
MNARmissingDis<-hist(MNAR_m$IncomeN, main="Distribution of Income (MNAR)", xlab="Income")
abline(v=mean(MNAR_m$IncomeN, na.rm=TRUE))
text(100000,5500,"Mean=$70296.97",col="red")
