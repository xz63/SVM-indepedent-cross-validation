# SVM-indepedent-cross-validation
This program provide a simple program to do machine learning using independent cross-validation 
If a data set has n Features and  m subjects and a label Y with 2 values, 1 or 2,  it is important that: 
n < m/2 and all the features are informative
for each feature, we can calculate the ttest between two groups and choose those with the largest t scores
using simple K-fold cross-validation, and using random sample, the performance can be 80% while the true accuracy should 50% because labels are random
indepdent cross-validation yield 50% for random data and more meaningful result
simple k-fold cross-validation yield infalted 80% for random data when subject number is around 40
Please cite our paper "??"
