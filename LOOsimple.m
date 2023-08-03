function [e,l,score]=LOOsimple(X,Y,b,isScramble)
% Author: Dr. Xian Zhang from Yale school of medicine, Psychiatry Department
% this program perform SVM machine learning for a binary classification
% X is matrix with Nfeature X nSubject
% Y is label of 1 or 2
% the leave one out cross-validation will based on selected features, where the feature is selected using all data, also call simple K-fold cross-validation
% if isScramble ==1   The label Y will be scrambled and result in  inflated 80% accuracy ( should be 50%)  if subject nubmer is near 40, run this 1000 times for calculating P value of performance  
% output:
%  e is error  1-accuracy, 
%  l is the label predicted by SVM
% score is the continuous score where score >0   indicates label is 1 
% a is the scrambled Y   or Y depend on the last input parameter
nS0=length(Y);
%[X, Y]=resampleML(X,Y);
nS=size(X,2);
switch isScramble
    case 1
        a=scramble2(Y);
    case 2 
        a=scramble3(Y);
    case 0
        a=Y;
end
[m,indf]=svmcFeature(X,a,b);
nS=size(X,2);
for i=1:nS0
    ind=1:nS;
    ind(i)=[];
    m=fitcsvm(X(indf,ind)',a(ind));
    [l(i) s]=predict(m,X(indf,i)');
    score(i)=s(1);
end
e=1-sum(l(:)==a(1:nS0))/nS0;
