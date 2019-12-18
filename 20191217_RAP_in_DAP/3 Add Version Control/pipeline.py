#Changes: 
#   - no changes to code

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
rescue_spark = spark.read.csv(
    "/training/animal_rescue.csv", 
    header=True, inferSchema=True, 
)

#DECISION: the dataset is 1.8MB, use pandas
rescue_incidents = rescue_spark.toPandas()
spark.stop()

#DECISION: drop nulls
rescue_incidents = rescue_incidents.dropna()

#DECISION: drop 2019
rescue_incidents = rescue_incidents[rescue_incidents['CalYear'] < 2019]

#Need to clean animal type variable
rescue_incidents['AnimalGroupParent'] = rescue_incidents['AnimalGroupParent'].str.title()

#DECISION: our report will be on the annual cost of cats for 
#the London Fire Brigade

cat_incidents = rescue_incidents[rescue_incidents['AnimalGroupParent'] == 'Cat']

aggregation_dictionary = {'IncidentNotionalCost(£)': 'sum'}

cats_chart = (
  (cat_incidents.groupby(['CalYear'])
    .agg(aggregation_dictionary)/1000)
    .plot(kind='bar', legend=False)
    .get_figure()
)


project_path = '/home/cdsw/rap-in-practice-python/3 Add Version Control/'
cats_chart.savefig(project_path + 'cats_cost_by_year_chart.png', dpi = 300)