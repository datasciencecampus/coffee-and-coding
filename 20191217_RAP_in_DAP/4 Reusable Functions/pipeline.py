#Changes:
# - added paths variables for ease of editing
# - put code into functions

import pandas as pd
import matplotlib.pylab as plt

animal_rescue_hdfs_path = '/training/animal_rescue.csv'
output_chart_path = '/home/cdsw/rap-in-practice-python/4 Reusable Functions/cats_cost_by_year.png'

#----------------------Level 1----------------------

def run_pipeline(input_path, output_path):
  rescue_incidents = read_data_to_pandas(input_path)
  rescue_cleaned = clean_data(rescue)
  cats_filtered = filter_data(rescue_cleaned)
  cats_by_year = get_cats_per_year(cats_filtered)
  cats_by_year_chart = make_chart(cats_by_year)
  save_chart(cats_by_year_chart, output_path)
  return 'Finished'

#----------------------Level 2----------------------

def read_data_to_pandas(input_path):
  spark = create_spark_connection()
  rescue_spark = spark.read.csv(input_path, 
                                header=True, 
                                inferSchema=True)
  rescue_pandas = rescue_spark.toPandas()
  spark.stop()
  return rescue_pandas


def clean_data(rescue):
  rescue['AnimalGroupParent'] = rescue['AnimalGroupParent'].str.title()
  rescue_cleaned = df.dropna()
  return rescue_cleaned


def filter_data(rescue_cleaned):
  cats_filtered = rescue_cleaned[(rescue_cleaned['CalYear'] < 2019) &\
                             (rescue_cleaned['AnimalGroupParent'] == "Cat")]
  return cats_filtered


def get_cats_per_year(cats_filtered):
  aggregation_dictionary = {'IncidentNotionalCost(£)': 'sum'}
  return cats_filtered.groupby(['CalYear']).agg(aggregation_dictionary)


def make_chart(cats_by_year):
  chart = (
      (cats_by_year/1000)
        .plot(kind='bar', legend=None)
        .get_figure()
  )
  plt.title('London fire brigade cost of cat incidents by year')
  plt.ylabel('Cost (£ thousands)')
  plt.xlabel('Year')
  return chart


def save_chart(chart, output_path):
  chart.savefig(output_path, dpi = 300)
  

#----------------------Level 3----------------------

def create_spark_connection():
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
  return spark


#----------------------Call pipeline----------------------

run_pipeline(animal_rescue_hdfs_path, output_chart_path)