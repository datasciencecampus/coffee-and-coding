# Why do we edit and impute data?
There are several challenges associated with data collecion, which can influence the quality of the statistical product. Editing and imputing can be used as a means of managing the imopact of these data collection issues on data quality.

## Perfect data vs. Actual data
In statistics, data is collected from units, which are commonly individuals, households or businesses. These collection units will provide values for a range of items/ variables. The purpose of data collection is to answer a question about a target population and target concept. As a result, it is intended that units and variables in the dataset are representative of the target population and target concept respectively.    
The perfect dataset is one where the design has captured a representative set of units, the variables have mapped out the target concept accurately, and all units have responded to all items in the collection instrument correctly. With a perfect dataset, the researcher can make reliable and precise inferences about the target population and concept, and in turn answer the question that prompted the data collection.  
  
In reality there are challenges in data collection, which impede the ability to capture a target population and concept. The representativeness of the target population and the measurement of the target concept can be impacted by:  
  
- Including units outside the target population  
- Excluding units in the target population  
- Using variables that do not map onto the target concept  
- Missingness  
- Erroneous responses  
  
The issues that arise in data collection will produce an answer to the research question that is further away from the “truth”.

## Statistical error
Statistical error is the difference between the estimate, produced by the data collection, and the unknown truth to the research question. The aim is to derive an estimate that is as close as possible to the “true value”. Differences between the estimate and the truth are driven by the bias and variance introduced in the statistical production cycle.  
  
Variance is the range by which an estimate could vary across multiple iterations of a given design. If a sample survey were to be carried out with the aim of measuring the amount of money donated to charities, there would be a variation in the estimates from different samples of the same design. That is, including different people in the sample may produce different estimates of the amount donated. Some samples may underestimate, whilst some overestimate; as a result, selection error (also referred to as sampling error) can be expressed as the range by which estimates vary as a result of sample composition.  
  
Bias is a consistent direction of difference between a parameter (i.e. true value) and its estimate across multiple iterations with a fixed design. In the example of the survey measuring charitable donations, there may be a consistent social desirability bias to overstate the amount donated. As a result, this measurement error can be expressed as the degree to which the survey design overestimates the amount that people donate to charities.  
  
The examples above illustrated how the selection of units and measurement of variables can introduce variance and bias respectively. Selection error and measurement error are both referred to as error sources, as they introduce statistical error; introducing more uncertainty in whether the estimate captures the unknown “truth”. There are multiple error sources in the statistical production cycle; some of which impact the representation of the target population and some of which impact the measurement of the underlying construct.

### Measurement error
Measurement error is the potential variation and bias introduced during collection. It could be the result of flaws in the collection instrument or due to how units provide responses. For example, people may mis-remember details or interpret questions differently from what was intended.

### Missingness
Missingness can be a result of non-response or data loading issues, and can impact the representation of the target population. There are three different types of missingness. All types of missingness will introduce variance into the estimate. However, the risk of bias is different between the different types of missingness.   
  
1) Missing completely at random (MCAR)  
2) Missing at random (MAR)  
3) Missing Not at random (NMAR)  
  
An income dataset is used to demonstrate the different types of missingness. It has three variables, age, sex and income. The age and sex variables were derived from the open Census Adult income dataset available on [Kaggle](https://www.kaggle.com/uciml/adult-census-income#adult.csv). Whilst the income variable was derived so that males on average had a higher income than females. In demonstrating each type of missingness, the income variable was set to have a missing proportion of 30%, whilst age and sex were set to have no missingness. The code used to derive the income variable, along with the first five units of the dataset are presented below.  


```r
#Separate males and females to generate income
DataMale<-DataK[DataK$sex=="Male",]
DataFemale<-DataK[DataK$sex=="Female",]

#Create income for males and females
DataMale$IncomeN<-rnorm(1:nrow(DataMale),80000,20000)
DataFemale$IncomeN<-rnorm(1:nrow(DataFemale),55000,10000)

#Append males and females into one dataset
DataK_edit<-rbind(DataMale,DataFemale)
```













