function [m ,ind,tvalglm]=svmcFeature(X,Y,nB)
% Author: Dr. Xian Zhang from Yale school of medicine, Psychiatry Department
% this program perform SVM machine learning for a binary classification
% X is matrix with Nfeature X nSubject
% Y is label of 1 or 2
% this program selected nfeature < Nfeature in X based on the ttest between a feature's Ttest between group 1 and group 2
% and perform SVM one time and return the SVM object for cross-validation
nS=size(X,2);
% if you only do univariant analysis nB=0
[nB1,nS]=size(X);
ind1=find(Y==max(Y));
ind2=find(Y==min(Y));
for b=1:nB1
    asd1= X(b,ind1)';
    td1=X(b,ind2)';
    [~,~,~,STATS]=ttest2(td1,asd1);
    tvalglm(b)=STATS.tstat;
end
[~,ind]=sort(-abs(tvalglm));
if nB==0
    m=0;
    return
end
ind=ind(1:nB);
m=fitcsvm(X(ind,:)',Y);
