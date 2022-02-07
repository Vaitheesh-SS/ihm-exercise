####Library import##########
import sys
import traceback
from pyspark.sql.session import SparkSession
from pyspark.sql.types import *
from subprocess import Popen, PIPE

####### Main Function ######
if __name__ == "__main__":
#######Spark Session ######
    spark=SparkSession\
            .builder\
            .appName("FileIngestion")\
            .enableHiveSupport()\
            .config("hive.exec.dynamic.partition","true")\
            .config("hive.exec.dynamic.partition.mode","nonstrict")\
            .config("spark.sql.caseSensitive","false")\
            .getOrCreate()

#####HDFS Path initialisation######
hdfs_path = '/path/to/the/designated/folder'

########Fetching the list of files from hdfs ######
process = Popen(f'hdfs dfs -ls -h {hdfs_path}', shell=True, stdout=PIPE, stderr=PIPE)
std_out, std_err = process.communicate()
list_of_file_names = [fn.split(' ')[-1].split('/')[-1] for fn in std_out.decode().split('\n')[1:]][:-1]
list_of_file_names_with_full_address = [fn.split(' ')[-1] for fn in std_out.decode().split('\n')[1:]][:-1]

########Database Creation #########
spark.sql('create database dbName')

#######Read individual files and load in seperate tables###########
for i in list_of_file_names_with_full_address:
    tableName=i.split("/")[-1]
    readFile=spark.read.format("csv").option("header","true").option("sep",",").load(i)
    readFile.write.format("orc").mode("overwrite").saveAsTable("dbName.tableName")
########Fetching the lsit of tables ########################
tableList=spark.sql('show tables from dbName').select("tableName")
ListtableList=tableList.rdd.flatMap(lambda x: x).collect()
tableColumn=[]
dataList=[]
###########Getting total number of columns for all the tables loaded #########
for i in ListtableList:
    tableColumn=tableColumn.append(spark.read.table("dbName.i").columns)
    dataList=dataList.append(spark.read.table("dbName.i").rdd.flatMap(lambda x: x).collect())
print("Question|Answer")
print("1|len(tableColumn")
dataListClean=[]
str=[]
#####Getting the list of word and count odf occurenrce ######
print ("Value | Count")
dataListClean = [word for line in dataList for word in line.split()]
for i in dataListClean:             
    # checking for the duplicacy
    if i not in str2:
        # insert value in str2
        str2.append(i) 
for i in range(0, len(str2)):
    # count the frequency of each word(present 
    # in str2) in str and print
    print('str2[i] |', str.count(str2[i]))
########Total number of records loaded in all tables ######      
rowCount=0
for i in ListtableList:
    rowCount += spark.read.table("dbName.i").count().collect()[0][0]

print("Question|Answer")
print("3|rowCount")

    