#imports
import pandas as pd
import numpy as np
import matplotlib.pylab as plt
from pyspark.sql import SparkSession

#set up spark connection
spark = (
    SparkSession.builder.appName("my-spark-app2")
    .config("spark.executor.memory", "1500m")
    .config("spark.executor.cores", 2)
    .config("spark.dynamicAllocation.enabled", 'true')
    .config('spark.dynamicAllocation.maxExecutors', 4)
    .config('spark.shuffle.service.enabled','true')
    .enableHiveSupport()
    .getOrCreate()
)

#import data
sdf = spark.read.csv(
    "/training/animal_rescue.csv", 
    header=True, inferSchema=True, 
)

#DECISION: the dataset is 1.8MB, use pandas
df = sdf.toPandas()
spark.stop()

#can we drop some columns?
df.columns
#DECISION: don't need most geographical info or special service details
df.drop(['Easting_m', 'Northing_m', 'Easting_rounded', 'Northing_rounded',
         'BoroughCode', 'Borough', 'StnGroundName','SpecialServiceType', 
         'WardCode', 'Ward','SpecialServiceTypeCategory'], 
        axis=1, inplace=True)
df.columns

#is incident number a unique column?
len(np.unique(df['IncidentNumber'])) == len(df)
#True

#are there any duplicates?
dups = df.duplicated()
dups.sum()
#No

#are there any missing values?
nulls = df.isnull().sum()
nulls[nulls>0]
nulls.max() / len(df) * 100
#0.6% of rows in 3 columns
#DECISION: drop nulls
df = df.dropna()
nulls_check = df.isnull().sum()
nulls_check
#Done

#convert date column to datetime
df['DateTimeOfCall'] = pd.to_datetime(df['DateTimeOfCall'], 
                                      infer_datetime_format=True)
#span of dates?
df['DateTimeOfCall'].min()
#start 1st Jan 2009
df['DateTimeOfCall'].max()
#ends 1st Nov 2019

#Not a full year in 2019, is there an obvious drop in counts?
agg_dict = {'IncidentNumber':'count'}
df.groupby('CalYear').agg(agg_dict).plot(kind='bar')
#yes, obvious drop
#DECISION: drop 2019
df = df[df['CalYear'] < 2019]
#check
df.groupby('CalYear').agg(agg_dict).plot(kind='bar')

#how many different animal types are there?
len(np.unique(df['AnimalGroupParent']))
#27

#what are the most frequently rescued animals?
agg_dict = {'IncidentNumber': 'count'}
animal_count = df.groupby(['AnimalGroupParent']).agg(agg_dict)
animal_count.sort_values('IncidentNumber', inplace=True, ascending=False)
animal_count[:15]
#Cats, but, there are some cases of Cat and cat in the data- need to clean
df['AnimalGroupParent'] = df['AnimalGroupParent'].str.title()
animal_count = df.groupby(['AnimalGroupParent']).agg(agg_dict)
animal_count.sort_values('IncidentNumber', inplace=True, ascending=False)
animal_count[:15]

#DECISION: our report will be on the annual cost of cats for 
#the London Fire Brigade

cats = df[df['AnimalGroupParent'] == 'Cat']
agg_dict = {'IncidentNotionalCost(£)': 'sum'}

(
  (cats.groupby(['CalYear'])
       .agg(agg_dict)
        /1000)
      .plot(kind='bar', legend=False)
)

project_path = '/home/cdsw/rap-in-practice-python/4 Reusable Functions/'
cats_chart.savefig(project_path + 'cats_cost_by_year_chart.png', dpi = 300)