# SVM-indepedent-cross-validation
This post provides a simple program to do machine learning using nested cross-validation 
If a data set has n Features and  m subjects and a label Y with 2 values, 1 or 2,  it is important that: 
n < m/2 and all the features are informative. 
For each feature, we can calculate the ttest between two groups and choose those with the largest t scores. 
Using simple K-fold cross-validation, and using a random sample, the performance can be 80% while the true accuracy should be 50% because labels are random. 
Nested cross-validation yield near 50% for random data and thus is a more meaningful result.
run test.m for the demo
Please cite our paper "Prediction of Individual Autism Diagnostic Observation Schedule (ADOS) Scores Based on Neural Responses During Live Eye-to-Eye Contact"
