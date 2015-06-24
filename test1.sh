# -*- coding: utf-8 -*-
"""
Created on Fri Jun 19 19:39:16 2015

@author: z.fu
"""
from pyspark.sql import HiveContext
from __future__ import print_function
from pyspark import SparkContext
import re
import sys


sc = SparkContext(master="spark://SH02SVR2882:17777,SH02SVR2883:17777", appName="Rank Factor HotelApp Test computation ")
#1. transleate the dataset to data 
#2. get a  judgment from data
def check_filter(row): 
    #print row
    for index in range(len(row)):
        line=row[index]
        #print line
        errorreason=re.findall(r'[^a-zA-Z0-9/./-]+', line)
        if errorreason:
            row[index] = errorreason            
        else:            
            row[index] = "ok"
    return row

	
	
	

if __name__ == '__main__':
    
    tesdata1="hdfs://ns/user/hotel/fuzhengg/test/testdata"
    data=sc.textFile(testdata1).map(lambda row:row.encode('utf-8').split("\t")
    dataset=data.map(lambda row:check_filter(row)).cache()
    finnaldata=dataset.collect()
    return finnaldata