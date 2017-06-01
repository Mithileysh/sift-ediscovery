# -*- coding: utf-8 -*-
"""
Created on Mon Sep 19 12:21:40 2016

@author: sbbk529
"""

import csv as csv 
import numpy as np
import pandas as pd

from scipy import stats
import matplotlib.pyplot as plt


keywords = ["FERC", "Affair", "Devastating", "Investigation", "Disclosure", "Bonus", "Meeting", "Plan", "Services", "Report"]


emailData = pd.read_csv('emailMessagesAll.csv')
print (emailData.head()) # check if everything is in place

keywordMatches = []
for keyword in keywords: 
    keywordMatches.append([])

    
for index, row in emailData.iterrows():
    
    for i, keyword in enumerate(keywords):        
        hasKeyword = keyword.lower() in str(row[9]).lower()
        keywordMatches[i].append(int(hasKeyword))

print("Booleans done")

for index, keyword in enumerate(keywords):  
    colName = "has_" + keyword
    emailData[colName] = keywordMatches[index]
    #print (index, keywordMatches)
#print (len(keywordMatches))
    
emailData.to_csv("outMerged.csv", encoding='utf-8', index=False)

print("All done")