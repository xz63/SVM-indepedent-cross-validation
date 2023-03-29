function [e,l,score,a]=LOOindependent(X,Y,b,isScramble)
% Author: Dr. Xian Zhang from Yale school of medicine, Psychiatry Department
% this program perform SVM machine learning for a binary classification
% X is matrix with Nfeature X nSubject
% Y is label of 1 or 2
% the leave one out cross-validation will based on selected features, where the test data does NOT contribute to the feature selection.
% sif isScramble ==1   The label Y will be scrambled and result in  near 50% accuracy, run this 1000 times for calculating P value of performance  
% output:
%  e is error  1-accuracy, 
%  l is the label predicted by SVM
% score is the continuous score where score >0   indicates label is 1 
% a is the scrambled Y   or Y depend on the last input parameter
nS=size(X,2);
if isScramble==1
    a=scramble2(Y);
else
    a=Y;
end
for i=1:nS
    ind=1:nS;
    ind(i)=[];
    [m,indf]=svmcFeature(X(:,ind),a(ind),b);
    [l(i) s]=predict(m,X(indf,i)');
    score(i)=s(1);
end
e=1-sum(l(:)==a(:))/nS;
